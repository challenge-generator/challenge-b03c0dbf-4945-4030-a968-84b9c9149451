# Valores de variables para el ambiente de desarrollo
# Configuración optimizada para costos y pruebas funcionales

environment = "dev"

# Configuración de red - CIDR blocks para VPC
vpc_cidr = "10.0.0.0/16"
public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]
database_subnet_cidrs = ["10.0.20.0/24", "10.0.21.0/24", "10.0.22.0/24"]

# Configuración de disponibilidad
availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
single_nat_gateway = true
enable_dns_hostnames = true
enable_dns_support = true

# Configuración de compute - Instancias para desarrollo
instance_type = "t3.large"
min_instances = 2
max_instances = 4
desired_capacity = 2

# Configuración de EKS
cluster_version = "1.28"
node_instance_type = "m5.xlarge"
 eks_desired_capacity = 3
 eks_min_capacity = 2
 eks_max_capacity = 6

# Configuración de almacenamiento
storage_volume_size = 100
s3_bucket_versioning = true
enable_cross_region_replication = false

# Configuración de seguridad
enable_waf = false
enable_guardduty = false
enable_cloudtrail = true
kms_key_rotation = true

# Configuración de monitoreo
log_retention_days = 7
enable_detailed_monitoring = false
custom_metrics_enabled = true
alert_threshold_high = 80
alert_threshold_critical = 95

# Configuración de Big Data / Kinesis
kinesis_shard_count = 2
kinesis_retention_hours = 24
enable_kinesis_destination_logging = false

# Configuración de etiquetas
owner_tag = "platform-team"
cost_center_tag = "infrastructure-dev"
environment_tag = "development"
project_tag = "bigdata-hpc-platform"