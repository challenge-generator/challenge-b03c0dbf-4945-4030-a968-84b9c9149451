# Outputs del módulo de seguridad
# Superficie de práctica: el estudiante debe implementar los outputs requeridos
# según los requisitos de seguridad del proyecto

output "security_group_ids" {
  description = "IDs de los security groups creados"
  # value       = # TODO: retornar los IDs de los security groups
}

output "iam_role_arns" {
  description = "ARNs de los roles IAM creados"
  # value       = # TODO: retornar los ARNs de los roles IAM
}

output "kms_key_arn" {
  description = "ARN de la clave KMS"
  # value       = # TODO: retornar el ARN de la clave KMS
}

output "policy_arns" {
  description = "ARNs de las políticas IAM"
  # value       = # TODO: retornar los ARNs de las políticas
}