# Valores de variables para el ambiente de QA
# Configuración para pruebas de integración y rendimiento

environment = "qa"

# Configuración de red - CIDR blocks para VPC
vpc_cidr = "10.1.0.0/16"
public_subnet_cidrs = ["10.1.1.0/24", "10.1.2.0/24"]
private_subnet_cidrs = ["10.1.10.0/24", "10.1.11.0/24", "10.1.12.0/24"]
database_subnet_cidrs = ["10.1.20.0/24", "10.1.21.0/24", "10.1.22.0/24"]

# Configuración de disponibilidad - Multi-AZ para pruebas de HA
availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
single_nat_gateway = false
enable_dns_hostnames = true
enable_dns_support = true

# Configuración de compute - Capacidad media para QA
instance_type = "m5.2xlarge"
min_instances = 3
max_instances = 8
desired_capacity = 4

# Configuración de EKS
cluster_version = "1.28"
node_instance_type = "m5.2xlarge"
eks_desired_capacity = 4
eks_min_capacity = 3
eks_max_capacity = 10

# Configuración de almacenamiento
storage_volume_size = 500
s3_bucket_versioning = true
enable_cross_region_replication = false

# Configuración de seguridad - Habilitado para pruebas de cumplimiento
enable_waf = true
enable_guardduty = true
enable_cloudtrail = true
kms_key_rotation = true

# Configuración de monitoreo - Más detallado que dev
log_retention_days = 30
enable_detailed_monitoring = true
custom_metrics_enabled = true
alert_threshold_high = 75
alert_threshold_critical = 90

# Configuración de Big Data / Kinesis - Capacidad para pruebas de carga
kinesis_shard_count = 8
kinesis_retention_hours = 48
enable_kinesis_destination_logging = true

# Configuración de etiquetas
owner_tag = "platform-team"
cost_center_tag = "infrastructure-qa"
environment_tag = "qa"
project_tag = "bigdata-hpc-platform"