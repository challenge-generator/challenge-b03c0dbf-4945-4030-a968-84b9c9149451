variable "environment" {
  description = "Ambiente de despliegue (dev, qa, prod)"
  type        = string
}

variable "project_name" {
  description = "Nombre del proyecto para identificación de recursos"
  type        = string
}

variable "aws_region" {
  description = "Región de AWS"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC donde se desplegará el módulo de Big Data"
  type        = string
}

variable "subnet_ids" {
  description = "IDs de las subredes donde se desplegarán los recursos de Big Data"
  type        = list(string)
}

variable "cluster_configuration" {
  description = "Configuración del cluster de procesamiento de datos"
  type = object({
    cluster_type    = string
    instance_type   = string
    instance_count  = number
    master_instance = string
    core_instance   = number
    task_instance   = number
    instance_ebs_size = number
    encrypted       = bool
    termination_protection = bool
    visible_to_all_users = bool
  })
}

variable "emr_version" {
  description = "Versión de EMR a utilizar"
  type        = string
  default     = "emr-7.1.0"
}

variable "applications" {
  description = "Lista de aplicaciones a instalar en el cluster EMR"
  type        = list(string)
  default     = ["Spark", "Hive", "Livy", "JupyterEnterpriseGateway"]
}

variable "bootstrap_actions" {
  description = "Scripts de bootstrap para personalización del cluster"
  type = list(object({
    name = string
    path = string
    args = list(string)
  }))
  default = []
}

variable "steps" {
  description = "Pasos de EMR a ejecutar durante la creación del cluster"
  type = list(object({
    name          = string
    action_on_failure = string
    jar           = string
    main_class    = optional(string)
    args          = list(string)
  }))
  default = []
}

variable "kinesis_configuration" {
  description = "Configuración de Kinesis Data Streams"
  type = object({
    stream_name             = string
    shard_count             = number
    retention_period_hours  = number
    encryption_type         = string
    kms_key_id              = optional(string)
    enhanced_monitoring     = list(string)
  })
}

variable "kinesis_firehose" {
  description = "Configuración de Kinesis Data Firehose"
  type = object({
    name                           = string
    destination                    = string
    s3_bucket_arn                  = string
    s3_prefix                      = optional(string)
    s3_buffer_size                 = number
    s3_buffer_interval             = number
    compression_format             = string
    encryption_enabled             = bool
    kms_key_arn                    = optional(string)
    log_group_name                 = string
  })
  default = null
}

variable "redshift_configuration" {
  description = "Configuración de Redshift para data warehousing"
  type = object({
    cluster_identifier      = string
    database_name           = string
    master_username         = string
    master_password         = string
    node_type               = string
    cluster_type            = number
    encrypted               = bool
    kms_key_id              = optional(string)
    enhanced_vpc_routing    = bool
    publicly_accessible     = bool
    skip_final_snapshot     = bool
    final_snapshot_name     = optional(string)
    automated_snapshot_retention_days = number
    manual_snapshot_retention_days    = number
    port                    = number
  })
  default = null
}

variable "s3_data_lake" {
  description = "Configuración del Data Lake en S3"
  type = object({
    bucket_name             = string
    versioning_enabled      = bool
    server_side_encryption  = string
    kms_key_arn             = optional(string)
    lifecycle_rules = list(object({
      id      = string
      status  = string
      transition = list(object({
        days          = number
        storage_class = string
      }))
    }))
    cross_region_replication = bool
    replication_role_arn    = optional(string)
  })
}

variable "glue_configuration" {
  description = "Configuración de AWS Glue para ETL"
  type = object({
    glue_version      = string
    worker_type       = number
    number_of_workers = number
    max_capacity      = optional(number)
    catalog_id        = optional(string)
    database_name     = string
    table_prefix      = optional(string)
  })
  default = null
}

variable "athena_configuration" {
  description = "Configuración de Athena para consultas SQL sobre S3"
  type = object({
    workgroup_name    = string
    description       = string
    engine_version    = string
    output_location   = string
    encryption_option = string
    kms_key_arn       = optional(string)
  })
  default = null
}

variable "security_configuration" {
  description = "Configuración de seguridad para Big Data"
  type = object({
    enable_vpc_endpoint       = bool
    enable_private_dns        = bool
    enable_cloudtrail         = bool
    enable_access_logs        = bool
    access_logs_bucket        = optional(string)
    enable_macie              = bool
    macie_frequency           = optional(string)
    enable_guardduty          = bool
    guardduty_frequency       = optional(string)
  })
}

variable "auto_scaling" {
  description = "Configuración de auto scaling para el cluster"
  type = object({
    enable_auto_scaling    = bool
    min_capacity           = number
    max_capacity           = number
    scaling_adjustment     = number
    cooldown_period        = number
    metric_type            = string
    target_value           = number
  })
  default = null
}

variable "logging_configuration" {
  description = "Configuración de logging para componentes de Big Data"
  type = object({
    enable_emr_logging    = bool
    emr_log_bucket        = optional(string)
    enable_s3_access_log  = bool
    s3_access_log_bucket  = optional(string)
    log_expiration_days   = number
  })
}

variable "backup_configuration" {
  description = "Configuración de backups para datos críticos"
  type = object({
    enable_backup          = bool
    backup_schedule        = string
    retention_days         = number
    backup_destination     = string
    backup kms_key_arn     = optional(string)
  })
  default = null
}

variable "tags" {
  description = "Etiquetas personalizadas para recursos de Big Data"
  type        = map(string)
  default     = {}
}

variable "enable_monitoring" {
  description = "Habilitar monitoreo detallado del cluster"
  type        = bool
  default     = true
}

variable "notifications" {
  description = "Configuración de notificaciones SNS"
  type = object({
    enable_notifications = bool
    notification_types   = list(string)
    sns_topic_arn        = optional(string)
  })
}