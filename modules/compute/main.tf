locals {
  compute_tags = merge(
    var.tags,
    {
      "Component" = "compute"
      "Environment" = var.environment
    }
  )
}

# Módulo EKS Cluster principal para Big Data
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = var.eks_cluster_name
  cluster_version = var.kubernetes_version

  vpc_id                         = var.vpc_id
  subnet_ids                     = var.private_subnet_ids
  cluster_endpoint_public_access = var.eks_endpoint_public_access

  eks_managed_node_group_defaults = {
    ami_type       = var.eks_node_ami_type
    instance_types = var.eks_instance_types
  }

  eks_managed_node_groups = var.eks_node_groups

  cluster_enabled_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  enable_cluster_encryption = true
  cluster_encryption_config = [
    {
      provider_key_arn = var.kms_key_arn
      resources        = ["secrets"]
    }
  ]

  tags = local.compute_tags
}

# Grupo de Placement para HPC cuando se requiere baja latencia
resource "aws_placement_group" "hpc_placement_group" {
  count = var.enable_hpc && var.hpc_placement_group_strategy != "" ? 1 : 0

  name     = "${var.name_prefix}-hpc-${var.environment}"
  strategy = var.hpc_placement_group_strategy

  tags = local.compute_tags
}

# Auto Scaling Group para instancias de cómputo adicionales
resource "aws_launch_template" "compute_lt" {
  count = var.enable_autoscaling ? 1 : 0

  name_prefix   = "${var.name_prefix}-compute-lt-"
  image_id      = var.compute_instance_ami
  instance_type = var.compute_instance_type

  ebs_optimized = var.compute_ebs_optimized

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = var.compute_root_volume_size
      volume_type = var.compute_root_volume_type
      encrypted   = true
      kms_key_id  = var.kms_key_arn
    }
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  monitoring {
    enabled = true
  }

  tag_specifications {
    resource_type = "instance"
    tags          = local.compute_tags
  }

  user_data = base64encode(<<-EOF
              #!/bin/bash
              echo "ECS_CLUSTER=${var.ecs_cluster_name}" >> /etc/ecs/ecs.config
              EOF
            )

  lifecycle {
    create_before_destroy = true
  }

  tag_specifications {
    resource_type = "volume"
    tags          = local.compute_tags
  }
}

resource "aws_autoscaling_group" "compute_asg" {
  count = var.enable_autoscaling ? 1 : 0

  name                = "${var.name_prefix}-compute-asg-${var.environment}"
  vpc_zone_identifier = var.private_subnet_ids
  desired_capacity    = var.compute_desired_capacity
  min_size            = var.compute_min_size
  max_size            = var.compute_max_size
  health_check_type   = "ELB"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.compute_lt[0].id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.name_prefix}-compute-node-${var.environment}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = var.environment
    propagate_at_launch = true
  }

  tag {
    key                 = "Component"
    value               = "compute"
    propagate_at_launch = true
  }

  dynamic "tag" {
    for_each = var.tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Políticas IAM para el rol del nodo EKS
resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  for_each = module.eks.eks_managed_node_groups

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = each.value.node_role_name
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  for_each = module.eks.eks_managed_node_groups

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = each.value.node_role_name
}

resource "aws_iam_role_policy_attachment" "eks_container_registry_policy" {
  for_each = module.eks.eks_managed_node_groups

  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = each.value.node_role_name
}

# Security Group para el cluster EKS
module "eks_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "${var.name_prefix}-eks-${var.environment}"
  description = "Security group for EKS cluster ${var.eks_cluster_name}"
  vpc_id      = var.vpc_id

  ingress_rules = [
    { from_port = 443, to_port = 443, protocol = "tcp", description = "Kubernetes API" },
    { from_port = 10250, to_port = 10250, protocol = "tcp", description = "Kubelet API" },
  ]

  egress_rules = ["all-all"]

  tags = local.compute_tags
}

# ECS Cluster para cargas de trabajo de contenedores
resource "aws_ecs_cluster" "main" {
  count = var.enable_ecs ? 1 : 0

  name = var.ecs_cluster_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  configuration {
    execute_command_configuration {
      logging = "DEFAULT"
    }
  }

  tags = local.compute_tags
}

resource "aws_ecs_cluster_capacity_providers" "main" {
  count = var.enable_ecs ? 1 : 0

  cluster_name = aws_ecs_cluster.main[0].name

  capacity_providers = ["FARGATE", "FARGATE_SPOT"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}