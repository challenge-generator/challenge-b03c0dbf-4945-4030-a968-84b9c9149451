# Variables para el módulo de seguridad (IAM, políticas de acceso, etc.)
# Superficie de práctica: los valores se definirán en los archivos de implementación
del módulo.

variable "iam_role_name" {
  description = "Nombre del rol IAM para servicios y aplicaciones"
  type        = string
}

variable "iam_policy_arns" {
  description = "ARNs de políticas IAM a adjuntar al rol"
  type        = list(string)
  default     = []
}

variable "eks_cluster_name" {
  description = "Nombre del cluster EKS para asociar roles y políticas"
  type        = string
}

variable "s3_bucket_arn" {
  description = "ARN del bucket S3 para políticas de acceso"
  type        = string
}

variable "kinesis_stream_arn" {
  description = "ARN del stream Kinesis para políticas de acceso"
  type        = string
}

variable "rds_instance_arn" {
  description = "ARN de la instancia RDS para políticas de acceso"
  type        = string
}

variable "tags" {
  description = "Etiquetas comunes para todos los recursos del módulo"
  type        = map(string)
  default     = {}
}