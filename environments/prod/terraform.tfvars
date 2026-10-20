# Valores de variables para el ambiente de producción
# Configuración de alta disponibilidad para SLA 99.99% y 50k TPS

environment = "prod"

# Configuración de red - CIDR blocks para VPC producción
vpc_cidr = "10.2.0.0/16"
public_subnet_cidrs = ["10.2.1.0/24", "10.2.2.0/24", "10.2.3.0/24"]
private_subnet_cidrs = ["10.2.10.0/24", "10.2.11.0/24", "10.2.12.0/24", "10.2.13.0/24", "10.2.14.0/24", "10.2.15.0/24"]
database_subnet_cidrs = ["10.2.20.0/24", "10.2.21.0/24", "10.2.22.0/24"]

# Configuración de disponibilidad - Alta disponibilidad completa
availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"]
single_nat_gateway = false
enable_dns_hostnames = true
enable_dns_support = true

# Configuración de compute - Alta capacidad para 50k TPS
instance_type = "r6i.4xlarge"
min_instances = 10
max_instances = 50
desired_capacity = 20

# Configuración de EKS
cluster_version = "1.28"
node_instance_type = "r6i.4xlarge"
eks_desired_capacity = 15
eks_min_capacity = 10
eks_max_capacity = 50

# Configuración de almacenamiento - Alta capacidad y redundancia
storage_volume_size = 2000
s3_bucket_versioning = true
enable_cross_region_replication = true
replication_destination_region = "us-west-2"

# Configuración de seguridad - Cumplimiento completo GDPR/CCPA
enable_waf = true
enable_guardduty = true
enable_cloudtrail = true
kms_key_rotation = true
enable_macie = true
enable_security_hub = true

# Configuración de monitoreo - Observabilidad completa
log_retention_days = 90
enable_detailed_monitoring = true
custom_metrics_enabled = true
alert_threshold_high = 70
alert_threshold_critical = 85
enable_health_check = true
enable_canary_deployment = false

# Configuración de Big Data / Kinesis - Capacidad para producción
kinesis_shard_count = 64
kinesis_retention_hours = 168
enable_kinesis_destination_logging = true
kinesisEnhancedFanOut = true
kinesisConsumerCount = 4

# Configuración de recuperación ante desastres
enable_backup = true
backup_retention_days = 30
rto_minutes = 30
rpo_minutes = 5

# Configuración de etiquetas
owner_tag = "platform-team"
cost_center_tag = "infrastructure-prod"
environment_tag = "production"
project_tag = "bigdata-hpc-platform"
compliance_tag = "gdpr-ccpa"