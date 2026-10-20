# Outputs del módulo de almacenamiento
# Expone ARNs, endpoints y referencias para otros módulos

output "bucket_bigdata_arn" {
  description = "ARN del bucket S3 para Big Data"
  value       = aws_s3_bucket.bigdata.arn
}

output "bucket_bigdata_name" {
  description = "Nombre del bucket S3 para Big Data"
  value       = aws_s3_bucket.bigdata.id
}

output "bucket_landing_arn" {
  description = "ARN del bucket S3 para datos landing"
  value       = aws_s3_bucket.landing.arn
}

output "bucket_landing_name" {
  description = "Nombre del bucket S3 para datos landing"
  value       = aws_s3_bucket.landing.id
}

output "bucket_procesados_arn" {
  description = "ARN del bucket S3 para datos procesados"
  value       = aws_s3_bucket.procesados.arn
}

output "bucket_procesados_name" {
  description = "Nombre del bucket S3 para datos procesados"
  value       = aws_s3_bucket.procesados.id
}

output "efs_id" {
  description = "ID del sistema de archivos EFS"
  value       = aws_efs_file_system.hpc.id
}

output "efs_dns_name" {
  description = "Nombre DNS del sistema de archivos EFS"
  value       = aws_efs_file_system.hpc.dns_name
}

output "efs_mount_target_ids" {
  description = "IDs de los mount targets de EFS"
  value       = aws_efs_mount_target.hpc_private[*].id
}

output "efs_security_group_id" {
  description = "ID del security group de EFS"
  value       = aws_security_group.efs.id
}

output "rds_instance_id" {
  description = "ID de la instancia RDS"
  value       = aws_db_instance.principal.id
}

output "rds_instance_endpoint" {
  description = "Endpoint de la instancia RDS"
  value       = aws_db_instance.principal.endpoint
}

output "rds_instance_address" {
  description = "Dirección de la instancia RDS"
  value       = aws_db_instance.principal.address
}

output "rds_instance_port" {
  description = "Puerto de la instancia RDS"
  value       = aws_db_instance.principal.port
}

output "rds_security_group_id" {
  description = "ID del security group de RDS"
  value       = aws_security_group.rds.id
}

output "dynamodb_transacciones_name" {
  description = "Nombre de la tabla DynamoDB de transacciones"
  value       = aws_dynamodb_table.transacciones.name
}

output "dynamodb_transacciones_arn" {
  description = "ARN de la tabla DynamoDB de transacciones"
  value       = aws_dynamodb_table.transacciones.arn
}

output "dynamodb_sesiones_name" {
  description = "Nombre de la tabla DynamoDB de sesiones"
  value       = aws_dynamodb_table.sesiones.name
}

output "dynamodb_sesiones_arn" {
  description = "ARN de la tabla DynamoDB de sesiones"
  value       = aws_dynamodb_table.sesiones.arn
}

output "kms_key_arn" {
  description = "ARN de la clave KMS de almacenamiento"
  value       = aws_kms_key.almacenamiento.arn
}

output "kms_key_id" {
  description = "ID de la clave KMS de almacenamiento"
  value       = aws_kms_key.almacenamiento.key_id
}