# Módulo de seguridad - SUPERFICIE DE PRÁCTICA
# Stub: el estudiante implementará las políticas IAM, roles y configuraciones de seguridad

locals {
  nombre_proyecto = var.nombre_proyecto
  entorno        = var.entorno
  etiquetas      = merge(var.etiquetas_comunes, { Entorno = local.entorno })
}

# Este módulo espera las siguientes variables que deben ser proporcionadas por el llamador:
# - nombre_proyecto: string
# - entorno: string
# - vpc_id: string
# - subredes_privadas: list(string)
# - bucket_bigdata_arn: string
# - bucket_landing_arn: string
# - bucket_procesados_arn: string
# - efs_id: string
# - rds_instance_endpoint: string
# - dynamodb_tablas: map(string)
# - cluster_eks_name: string
# - etiquetas_comunes: map(string)

# El estudiante deberá implementar:
# - Políticas IAM para roles de compute (EC2, ECS, EKS)
# - Políticas IAM para roles de Big Data (EMR, Glue, Kinesis)
# - Security Groups para las diferentes capas
# - Configuración de KMS para claves adicionales
# - Políticas de acceso a buckets S3
# - Roles IAM con principio de menor privilegio

resource "aws_iam_role" "placeholder" {
  name = "placeholder-role-${local.entorno}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })

  tags = local.etiquetas
}

# Stub: aquí el estudiante implementará las políticas IAM reales
# según los requisitos de seguridad del reto