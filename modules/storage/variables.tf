# Variables para el módulo de almacenamiento (S3, EFS, etc.)

variable "s3_bucket_name" {
  description = "Nombre del bucket S3 para almacenamiento de datos"
  type        = string
}

variable "s3_storage_class" {
  description = "Clase de almacenamiento para objetos en S3 (STANDARD, INFREQUENT_ACCESS, etc.)"
  type        = string
  default     = "STANDARD"
}

variable "s3_versioning" {
  description = "Habilitar versionado en el bucket S3"
  type        = bool
  default     = true
}

variable "s3_server_side_encryption" {
  description = "Habilitar cifrado del lado del servidor para el bucket S3"
  type        = bool
  default     = true
}

variable "s3_block_public_access" {
  description = "Bloquear acceso público al bucket S3"
  type        = bool
  default     = true
}

variable "kinesis_stream_name" {
  description = "Nombre del stream Kinesis para procesamiento de datos en tiempo real"
  type        = string
}

variable "kinesis_shard_count" {
  description = "Número de shards para el stream Kinesis"
  type        = number
}

variable "efs_creation_token" {
  description = "Token de creación para el sistema de archivos EFS"
  type        = string
  default     = ""
}

variable "efs_performance_mode" {
  description = "Modo de rendimiento para EFS (generalPurpose o maxIO)"
  type        = string
  default     = "generalPurpose"
}

variable "efs_throughput_mode" {
  description = "Modo de throughput para EFS (bursting o provisioned)"
  type        = string
  default     = "bursting"
}

variable "efs_provisioned_throughput_in_mibps" {
  description = "Throughput provisionado para EFS en MiB/s (solo si throughput_mode = "provisioned")"
  type        = number
  default     = 0
}

variable "tags" {
  description = "Etiquetas comunes para todos los recursos del módulo"
  type        = map(string)
  default     = {}
}