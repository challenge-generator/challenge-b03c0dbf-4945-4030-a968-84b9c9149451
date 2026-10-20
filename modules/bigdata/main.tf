terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# =============================================================================
# MÓDULO DE BIG DATA - Servicios de procesamiento y análisis de gran escala
# =============================================================================
# Este módulo provisiona la infraestructura necesaria para soluciones de Big Data
# incluyendo streaming, almacenamiento de eventos, procesamiento distribuido y
# data warehousing. Cada servicio sigue principios de alta disponibilidad y
# escalabilidad horizontal para cumplir con los requisitos de 50K req/s.

# -----------------------------------------------------------------------------# KINESIS DATA STREAM - Ingesta de streaming en tiempo real
# -----------------------------------------------------------------------------resource "aws_kinesis_stream" "main" {
  name             = "${var.project_name}-${var.environment}-kinesis-stream"
  shard_count      = var.kinesis_shard_count
  retention_period = var.kinesis_retention_hours
  shard_level_metrics = ["IncomingBytes", "OutgoingBytes"]

  stream_mode_details {
    stream_mode = "PROVISIONED"
  }

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-${var.environment}-kinesis-stream"
      ServiceType = "KinesisDataStreams"
      Environment = var.environment
    }
  )
}

# Kinesis Server-Side Encryption
resource "aws_kinesis_stream_consumer" "analytics_consumer" {
  for_each = toset(var.kinesis_consumers)

  stream_arn = aws_kinesis_stream.main.arn
  name       = "${var.project_name}-${var.environment}-${each.key}-consumer"

  tags = merge(var.common_tags, {
    ConsumerName = each.key
  })
}

# -----------------------------------------------------------------------------# MSK (Managed Streaming for Apache Kafka) - Broker de mensajes
# -----------------------------------------------------------------------------resource "aws_msk_cluster" "main" {
  cluster_name           = "${var.project_name}-${var.environment}-msk"
  kafka_version          = var.msk_kafka_version
  number_of_broker_nodes = var.msk_broker_nodes

  broker_node_group_info {
    instance_type   = var.msk_instance_type
    client_subnets  = var.private_subnet_ids
    security_groups = [aws_security_group.msk.id]
    storage_info {
      ebs_storage_info {
        volume_size = var.msk_storage_size
      }
    }
  }

  encryption_info {
    encryption_at_rest_kms_key_arn = var.kms_key_arn
    encryption_in_transit {
      client_broker = "TLS"
      in_cluster    = true
    }
  }

  logging_info {
    broker_logs {
      cloudwatch_logs {
        enabled   = true
        log_group = aws_cloudwatch_log_group.msk.id
      }
      s3 {
        enabled = true
        bucket  = aws_s3_bucket.msk_logs.id
      }
    }
  }

  open_monitoring {
    prometheus {
      enabled = true
    }
  }

  tags = merge(var.common_tags, {
    Name        = "${var.project_name}-${var.environment}-msk"
    ServiceType = "MSK"
  })
}

resource "aws_cloudwatch_log_group" "msk" {
  name              = "/aws/msk/${var.project_name}-${var.environment}"
  retention_in_days = var.log_retention_days

  tags = var.common_tags
}

resource "aws_s3_bucket" "msk_logs" {
  bucket = "${var.project_name}-${var.environment}-msk-logs"

  tags = merge(var.common_tags, {
    Name = "MSK Logs Bucket"
  })
}

resource "aws_s3_bucket_server_side_encryption_configuration" "msk_logs" {
  bucket = aws_s3_bucket.msk_logs.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.kms_key_arn
      sse_algorithm     = "aws:kms"
    }
  }
}

# -----------------------------------------------------------------------------# EMR - Procesamiento distribuido con Spark/Hadoop
# -----------------------------------------------------------------------------resource "aws_emr_cluster" "main" {
  name                  = "${var.project_name}-${var.environment}-emr-cluster"
  release_label         = var.emr_release_label
  applications          = var.emr_applications
  service_role          = aws_iam_role.emr_service_role.arn
  security_configuration = aws_emr_security_configuration.emr_sec_config.id

  core_instance_group {
    instance_type  = var.emr_core_instance_type
    instance_count = var.emr_core_instance_count
    ebs_config {
      size                 = var.emr_core_ebs_size
      type                 = "gp3"
      volumes_per_instance = 1
    }
  }

  master_instance_group {
    instance_type = var.emr_master_instance_type
    instance_count = 1
    ebs_config {
      size                 = var.emr_master_ebs_size
      type                 = "gp3"
      volumes_per_instance = 1
    }
  }

  ec2_attributes {
    emr_managed_master_security_group = aws_security_group.emr_master.id
    emr_managed_slave_security_group  = aws_security_group.emr_slave.id
    instance_profile                  = aws_iam_instance_profile.emr_ec2.arn
    subnet_id                         = var.private_subnet_ids[0]
  }

  step_concurrency_level = var.emr_step_concurrency

  tags = merge(var.common_tags, {
    Name        = "${var.project_name}-${var.environment}-emr"
    ServiceType = "EMR"
  })
}

resource "aws_emr_security_configuration" "emr_sec_config" {
  name = "${var.project_name}-${var.environment}-emr-sec-config"

  configuration = jsonencode({
    "EncryptionConfiguration" : {
      "EnableAtRestEncryption" : true,
      "EnableInTransitEncryption" : true,
      "AtRestEncryptionConfiguration" : {
        "S3EncryptionConfiguration" : {
          "EncryptionMode" : "SSE-KMS",
          "KmsKeyArn"       = var.kms_key_arn
        }
      },
      "InTransitEncryptionConfiguration" : {
        "TLSCertificateConfiguration" : {
          "CertificateArn" : var.acm_certificate_arn
        }
      }
    }
  })
}

# -----------------------------------------------------------------------------# AWS Glue - ETL serverless y Data Catalog
# -----------------------------------------------------------------------------resource "aws_glue_catalog_database" "data_lake" {
  name        = "${var.project_name}_${var.environment}_data_lake"
  description = "Data Lake metadata catalog for ${var.project_name}"

  parameters = {
    "CreatedBy" : "Terraform"
    "Environment" : var.environment
  }

  tags = var.common_tags
}

resource "aws_glue_crawler" "raw_data_crawler" {
  for_each = toset(var.glue_crawlers)

  name          = "${var.project_name}-${var.environment}-${each.key}-crawler"
  database_name = aws_glue_catalog_database.data_lake.name
  role          = aws_iam_role.glue_crawler_role.arn

  s3_target {
    path = "s3://${var.raw_data_bucket}/${each.key}/"
  }

  schema_change_policy {
    delete_behavior = "LOG"
    update_behavior = "LOG"
  }

  configuration = jsonencode({
    "Version" : 1,
    "CrawlerOutput" : {
      "Partitions" : {
        "AddOrUpdateBehavior" : "INHERIT_FROM_TABLE"
      }
    }
  })

  tags = merge(var.common_tags, {
    CrawlerName = each.key
  })
}

resource "aws_glue_job" "etl_job" {
  for_each = toset(var.glue_jobs)

  name     = "${var.project_name}-${var.environment}-${each.key}-job"
  role_arn = aws_iam_role.glue_job_role.arn
  glue_version = var.glue_glue_version
  worker_type  = var.glue_worker_type
  number_of_workers = var.glue_number_of_workers

  command {
    script_location = "s3://${var.glue_scripts_bucket}/${each.key}/etl_script.py"
    python_version  = "3"
  }

  default_arguments = {
    "--job-language"           = "python"
    "--enable-metrics"         = ""
    "--enable-continuous-cloudwatch-log" = "true"
    "--enable-spark-ui"        = "true"
    "--spark-event-log-path"   = "s3://${var.spark_ui_bucket}/spark-history/"
    "--extra-py-files"         = "s3://${var.glue_scripts_bucket}/common/utils.zip"
    "--TempDir"                = "s3://${var.temp_bucket}/"
  }

  execution_property {
    max_concurrent_runs = var.glue_max_concurrent_runs
  }

  tags = merge(var.common_tags, {
    JobName = each.key
  })
}

# -----------------------------------------------------------------------------# Amazon Redshift - Data Warehouse analítico
# -----------------------------------------------------------------------------resource "aws_redshift_cluster" "main" {
  cluster_identifier        = "${var.project_name}-${var.environment}-redshift"
  cluster_type              = var.redshift_cluster_type
  node_type                 = var.redshift_node_type
  number_of_nodes           = var.redshift_number_of_nodes
  master_username           = var.redshift_master_username
  master_password           = var.redshift_master_password
  database_name             = var.redshift_database_name
  port                      = var.redshift_port
  cluster_subnet_group_name = aws_redshift_subnet_group.main.name
  vpc_security_group_ids   = [aws_security_group.redshift.id]

  iam_roles = [aws_iam_role.redshift_s3_access.arn]

  logging {
    enable        = true
    bucket_name   = aws_s3_bucket.redshift_logs.id
    log_interval  = 300
  }

  encrypted             = true
  kms_key_id            = var.kms_key_arn
  skip_final_snapshot   = var.environment != "prod"
  final_cluster_snapshot_name = var.environment == "prod" ? "${var.project_name}-final-snapshot" : null

  parameter_group_name = aws_redshift_parameter_group.main.name

  lifecycle {
    ignore_changes = ["master_password"]
  }

  tags = merge(var.common_tags, {
    Name        = "${var.project_name}-${var.environment}-redshift"
    ServiceType = "Redshift"
  })
}

resource "aws_redshift_subnet_group" "main" {
  name       = "${var.project_name}-${var.environment}-redshift-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = var.common_tags
}

resource "aws_redshift_parameter_group" "main" {
  name   = "${var.project_name}-${var.environment}-redshift-params"
  family = var.redshift_parameter_family

  parameter {
    name  = "enable_user_activity_logging"
    value = "true"
  }

  parameter {
    name  = "statement_timeout"
    value = var.redshift_statement_timeout
  }
}

# -----------------------------------------------------------------------------# Security Groups para servicios de Big Data
# -----------------------------------------------------------------------------resource "aws_security_group" "msk" {
  name        = "${var.project_name}-${var.environment}-msk-sg"
  description = "Security group for MSK cluster"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 9092
    to_port     = 9092
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
    description = "MSK PLAINTEXT"
  }

  ingress {
    from_port   = 9094
    to_port     = 9094
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
    description = "MSK TLS"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, {
    Name = "MSK Security Group"
  })
}

resource "aws_security_group" "emr_master" {
  name        = "${var.project_name}-${var.environment}-emr-master-sg"
  description = "EMR Master node security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 8443
    to_port     = 8443
    protocol    = "tcp"
    self        = true
    description = "EMR Web UI"
  }

  ingress {
    from_port   = 9443
    to_port     = 9443
    protocol    = "tcp"
    self        = true
    description = "EMR History Server"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, {
    Name = "EMR Master Security Group"
  })
}

resource "aws_security_group" "emr_slave" {
  name        = "${var.project_name}-${var.environment}-emr-slave-sg"
  description = "EMR Core/Task nodes security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    self        = true
    description = "EMR Internal Communication"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, {
    Name = "EMR Slave Security Group"
  })
}

resource "aws_security_group" "redshift" {
  name        = "${var.project_name}-${var.environment}-redshift-sg"
  description = "Redshift cluster security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
    description = "Redshift"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, {
    Name = "Redshift Security Group"
  })
}