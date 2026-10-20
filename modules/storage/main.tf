# Módulo de almacenamiento para Big Data, HPC y datos estructurados
# Provee S3, EFS, RDS y DynamoDB con cifrado y alta disponibilidad

locals {
  nombre_base = var.nombre_proyecto
  entorno     = var.entorno
  etiquetas   = merge(var.etiquetas_comunes, { Entorno = local.entorno })
}

# Bucket S3 para Big Data - almacenamiento de objetos de alto volumen
resource "aws_s3_bucket" "bigdata" {
  bucket = "${local.nombre_base}-bigdata-${local.entorno}"

  tags = local.etiquetas
}

resource "aws_s3_bucket_versioning" "bigdata" {
  bucket = aws_s3_bucket.bigdata.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bigdata" {
  bucket = aws_s3_bucket.bigdata.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.almacenamiento.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "bigdata" {
  bucket = aws_s3_bucket.bigdata.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Bucket S3 para datos landing zone - ingestión de datos crudos
resource "aws_s3_bucket" "landing" {
  bucket = "${local.nombre_base}-landing-${local.entorno}"

  tags = local.etiquetas
}

resource "aws_s3_bucket_versioning" "landing" {
  bucket = aws_s3_bucket.landing.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "landing" {
  bucket = aws_s3_bucket.landing.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.almacenamiento.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "landing" {
  bucket = aws_s3_bucket.landing.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Bucket S3 para datos procesados - salida de pipelines
resource "aws_s3_bucket" "procesados" {
  bucket = "${local.nombre_base}-procesados-${local.entorno}"

  tags = local.etiquetas
}

resource "aws_s3_bucket_versioning" "procesados" {
  bucket = aws_s3_bucket.procesados.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "procesados" {
  bucket = aws_s3_bucket.procesados.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.almacenamiento.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "procesados" {
  bucket = aws_s3_bucket.procesados.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Sistema de archivos EFS para HPC - acceso compartido de alta velocidad
resource "aws_efs_file_system" "hpc" {
  creation_token = "${local.nombre_base}-hpc-${local.entorno}"

  encrypted = true
  kms_key_id = aws_kms_key.almacenamiento.arn

  tags = local.etiquetas
}

resource "aws_efs_mount_target" "hpc_private" {
  count = length(var.subredes_privadas)

  file_system_id  = aws_efs_file_system.hpc.id
  subnet_id       = var.subredes_privadas[count.index]
  security_groups = [aws_security_group.efs.id]
}

resource "aws_efs_access_point" "hpc_ap" {
  file_system_id = aws_efs_file_system.hpc.id

  posix_user {
    gid = 1000
    uid = 1000
  }

  root_directory {
    path = "/hpc-data"
    creation_info {
      owner_gid   = 1000
      owner_uid   = 1000
      permissions = "0755"
    }
  }

  tags = local.etiquetas
}

# RDS para datos estructurados - base de datos transaccional
resource "aws_db_instance" "principal" {
  identifier     = "${local.nombre_base}-${local.entorno}"
  engine         = var.motor_bd
  engine_version = var.version_motor_bd
  instance_class = var.clase_instancia_bd

  allocated_storage     = var.tamano_almacenamiento_bd
  max_allocated_storage = var.tamano_max_almacenamiento_bd

  storage_encrypted = true
  storage_type      = var.tipo_almacenamiento_bd

  db_name  = replace(local.nombre_base, "-", "_")
  username = var.usuario_admin_bd
  password = var.password_admin_bd

  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = var.nombre_subnet_group

  backup_retention_period = var.retension_backup
  backup_window           = "03:00-04:00"
  maintenance_window      = "mon:04:00-mon:05:00"

  skip_final_snapshot       = var.entorno != "prod"
  final_snapshot_identifier = var.entorno == "prod" ? "${local.nombre_base}-final-${local.entorno}" : null

  enabled_cloudwatch_logs_exports = ["error", "general", "slowquery"]

  performance_insights_enabled = var.entorno != "dev"
  performance_insights_kms_key = var.entorno != "dev" ? aws_kms_key.almacenamiento.arn : null

  tags = local.etiquetas
}

# DynamoDB para datos NoSQL de alta velocidad
resource "aws_dynamodb_table" "transacciones" {
  name           = "${local.nombre_base}-transacciones-${local.entorno}"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "pk"
  range_key      = "sk"

  server_side_encryption {
    enabled     = true
    kms_key_arn = aws_kms_key.almacenamiento.arn
  }

  attribute {
    name = "pk"
    type = "S"
  }

  attribute {
    name = "sk"
    type = "S"
  }

  attribute {
    name = "timestamp"
    type = "N"
  }

  global_secondary_index {
    name            = "timestamp-index"
    hash_key        = "pk"
    range_key       = "timestamp"
    projection_type = "ALL"
  }

  ttl {
    attribute_name = "expiracion"
    enabled        = true
  }

  tags = local.etiquetas
}

resource "aws_dynamodb_table" "sesiones" {
  name           = "${local.nombre_base}-sesiones-${local.entorno}"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "session_id"

  server_side_encryption {
    enabled     = true
    kms_key_arn = aws_kms_key.almacenamiento.arn
  }

  attribute {
    name = "session_id"
    type = "S"
  }

  ttl {
    attribute_name = "ttl"
    enabled        = true
  }

  tags = local.etiquetas
}

# Clave KMS para cifrado de almacenamiento
resource "aws_kms_key" "almacenamiento" {
  description             = "Clave KMS para cifrado de almacenamiento del proyecto ${local.nombre_base}"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  tags = merge(local.etiquetas, { Name = "${local.nombre_base}-kms-almacenamiento-${local.entorno}" })
}

resource "aws_kms_alias" "almacenamiento" {
  name          = "alias/${local.nombre_base}-almacenamiento-${local.entorno}"
  target_key_id = aws_kms_key.almacenamiento.key_id
}

# Security Groups
resource "aws_security_group" "efs" {
  name        = "${local.nombre_base}-efs-${local.entorno}"
  description = "Security group para EFS"
  vpc_id      = var.vpc_id

  tags = local.etiquetas
}

resource "aws_security_group_rule" "efs_ingress_nfs" {
  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  source_security_group_id = var.security_group_compute
  security_group_id        = aws_security_group.efs.id
}

resource "aws_security_group" "rds" {
  name        = "${local.nombre_base}-rds-${local.entorno}"
  description = "Security group para RDS"
  vpc_id      = var.vpc_id

  tags = local.etiquetas
}

resource "aws_security_group_rule" "rds_ingress_postgres" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = var.security_group_compute
  security_group_id        = aws_security_group.rds.id
}

resource "aws_security_group_rule" "rds_ingress_mysql" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = var.security_group_compute
  security_group_id        = aws_security_group.rds.id
}

resource "aws_security_group_rule" "rds_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.rds.id
}

# Políticas de ciclo de vida S3
resource "aws_s3_bucket_lifecycle_configuration" "bigdata" {
  bucket = aws_s3_bucket.bigdata.id

  rule {
    id     = "transition-to-glacier"
    status = "Enabled"

    transition {
      days          = 90
      storage_class = "GLACIER"
    }

    transition {
      days          = 365
      storage_class = "DEEP_ARCHIVE"
    }
  }

  rule {
    id     = "expiration"
    status = "Enabled"

    expiration {
      days = 2555
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "landing" {
  bucket = aws_s3_bucket.landing.id

  rule {
    id     = "transition-to-intelligent-tiering"
    status = "Enabled"

    transition {
      days          = 30
      storage_class = "INTELLIGENT_TIERING"
    }

    transition {
      days          = 90
      storage_class = "GLACIER"
    }
  }
}