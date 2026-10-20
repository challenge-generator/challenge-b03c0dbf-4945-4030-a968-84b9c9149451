# Declaración de variables globales para parametrizar la infraestructura
has	la capacidad de ser reutilizadas por todos los módulos.

variable "region" {
  description = "Región de AWS donde se desplegará la infraestructura"
  type        = string
}

variable "project_name" {
  description = "Nombre del proyecto para etiquetado consistente de recursos"
  type        = string
}

variable "environment" {
  description = "Ambiente de despliegue (dev, qa, prod)"
  type        = string
}

variable "vpc_cidr" {
  description = "Bloque CIDR para la VPC principal"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "Lista de bloques CIDR para subredes públicas"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Lista de bloques CIDR para subredes privadas"
  type        = list(string)
}

variable "database_subnet_cidrs" {
  description = "Lista de bloques CIDR para subredes de bases de datos"
  type        = list(string)
}

variable "eks_cluster_name" {
  description = "Nombre del cluster EKS"
  type        = string
}

variable "eks_cluster_version" {
  description = "Versión de Kubernetes para el cluster EKS"
  type        = string
}

variable "eks_node_instance_type" {
  description = "Tipo de instancia para los nodos del cluster EKS"
  type        = string
}

variable "eks_node_min_size" {
  description = "Número mínimo de nodos en el grupo de auto-scaling"
  type        = number
}

variable "eks_node_max_size" {
  description = "Número máximo de nodos en el grupo de auto-scaling"
  type        = number
}

variable "eks_node_desired_size" {
  description = "Número deseado de nodos en el grupo de auto-scaling"
  type        = number
}

variable "s3_bucket_name" {
  description = "Nombre del bucket S3 para almacenamiento de datos"
  type        = string
}

variable "s3_storage_class" {
  description = "Clase de almacenamiento para objetos en S3 (STANDARD, INFREQUENT_ACCESS, etc.)"
  type        = string
  default     = "STANDARD"
}

variable "kinesis_stream_name" {
  description = "Nombre del stream Kinesis para procesamiento de datos en tiempo real"
  type        = string
}

variable "kinesis_shard_count" {
  description = "Número de shards para el stream Kinesis"
  type        = number
}

variable "rds_instance_class" {
  description = "Clase de instancia para RDS"
  type        = string
}

variable "rds_allocated_storage" {
  description = "Almacenamiento asignado para RDS en GB"
  type        = number
}

variable "rds_engine_version" {
  description = "Versión del motor de base de datos para RDS"
  type        = string
}

variable "rds_multi_az" {
  description = "Habilitar despliegue multi-AZ para RDS"
  type        = bool
  default     = true
}

variable "cloudwatch_log_retention" {
  description = "Días de retención para logs en CloudWatch"
  type        = number
  default     = 30
}

variable "tags" {
  description = "Etiquetas comunes para todos los recursos"
  type        = map(string)
  default     = {}
}