output "eks_cluster_name" {
  description = "Nombre del cluster EKS"
  value       = module.eks.cluster_name
}

output "eks_cluster_id" {
  description = "ID del cluster EKS"
  value       = module.eks.cluster_id
}

output "eks_cluster_arn" {
  description = "ARN del cluster EKS"
  value       = module.eks.cluster_arn
}

output "eks_cluster_endpoint" {
  description = "Endpoint del cluster EKS"
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_certificate_authority_data" {
  description = "Datos del certificado CA del cluster EKS"
  value       = module.eks.cluster_certificate_authority_data
  sensitive   = true
}

output "eks_oidc_provider_arn" {
  description = "ARN del proveedor OIDC del cluster EKS"
  value       = module.eks.oidc_provider_arn
}

output "eks_oidc_provider_url" {
  description = "URL del proveedor OIDC del cluster EKS"
  value       = module.eks.oidc_provider_url
}

output "eks_security_group_id" {
  description = "ID del security group del cluster EKS"
  value       = module.eks_security_group.security_group_id
}

output "eks_node_group_arns" {
  description = "ARNs de los node groups del cluster EKS"
  value       = { for k, v in module.eks.eks_managed_node_groups : k => v.node_group_arn }
}

output "eks_node_group_ids" {
  description = "IDs de los node groups del cluster EKS"
  value       = { for k, v in module.eks.eks_managed_node_groups : k => v.node_group_id }
}

output "eks_node_group_statuses" {
  description = "Estados de los node groups del cluster EKS"
  value       = { for k, v in module.eks.eks_managed_node_groups : k => v.node_group_status }
}

output "eks_node_role_arn" {
  description = "ARN del rol de los nodos EKS"
  value       = values(module.eks.eks_managed_node_groups)[0].node_role_arn
}

output "ecs_cluster_id" {
  description = "ID del cluster ECS"
  value       = var.enable_ecs ? aws_ecs_cluster.main[0].id : null
}

output "ecs_cluster_arn" {
  description = "ARN del cluster ECS"
  value       = var.enable_ecs ? aws_ecs_cluster.main[0].arn : null
}

output "ecs_cluster_name" {
  description = "Nombre del cluster ECS"
  value       = var.enable_ecs ? aws_ecs_cluster.main[0].name : null
}

output "autoscaling_group_name" {
  description = "Nombre del Auto Scaling Group de cómputo"
  value       = var.enable_autoscaling ? aws_autoscaling_group.compute_asg[0].name : null
}

output "autoscaling_group_id" {
  description = "ID del Auto Scaling Group de cómputo"
  value       = var.enable_autoscaling ? aws_autoscaling_group.compute_asg[0].id : null
}

output "autoscaling_group_arn" {
  description = "ARN del Auto Scaling Group de cómputo"
  value       = var.enable_autoscaling ? aws_autoscaling_group.compute_asg[0].arn : null
}

output "launch_template_id" {
  description = "ID del Launch Template para cómputo"
  value       = var.enable_autoscaling ? aws_launch_template.compute_lt[0].id : null
}

output "hpc_placement_group_id" {
  description = "ID del Placement Group para HPC"
  value       = var.enable_hpc && var.hpc_placement_group_strategy != "" ? aws_placement_group.hpc_placement_group[0].id : null
}

output "hpc_placement_group_arn" {
  description = "ARN del Placement Group para HPC"
  value       = var.enable_hpc && var.hpc_placement_group_strategy != "" ? aws_placement_group.hpc_placement_group[0].arn : null
}

output "compute_node_instance_iam_role_arn" {
  description = "ARN del rol IAM para las instancias de cómputo"
  value       = var.enable_autoscaling ? aws_iam_role.compute_node_role[0].arn : null
}