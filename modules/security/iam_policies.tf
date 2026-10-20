# =============================================================================
# DEFINICIÓN DE POLÍTICAS IAM - SUPERFICIE DE PRÁCTICA
# =============================================================================
# Este archivo contiene las definiciones de políticas IAM que el candidato
# debe completar aplicando el principio de menor privilegio.

# Política para acceso a S3 - COMPLETAR por el estudiante
data "aws_iam_policy_document" "s3_access" {
  statement {
    sid = "AllowListBuckets"
    effect = "Allow"

    actions = [
      "s3:ListAllMyBuckets",
      "s3:ListBucket"
    ]

    resources = ["arn:aws:s3:::*"]
  }

  statement {
    sid = "AllowReadWriteSpecificBuckets"
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]

    # TODO: Especificar los ARNs de los buckets específicos del proyecto
    resources = []
  }
}

# Política para acceso a Kinesis - COMPLETAR por el estudiante
data "aws_iam_policy_document" "kinesis_access" {
  statement {
    sid = "AllowKinesisReadWrite"
    effect = "Allow"

    actions = [
      "kinesis:DescribeStream",
      "kinesis:GetRecords",
      "kinesis:GetShardIterator",
      "kinesis:ListShards",
      "kinesis:PutRecord",
      "kinesis:PutRecords"
    ]

    # TODO: Especificar el ARN del stream específico
    resources = []
  }
}

# Política para acceso a MSK - COMPLETAR por el estudiante
data "aws_iam_policy_document" "msk_access" {
  statement {
    sid = "AllowMSKConnect"
    effect = "Allow"

    actions = [
      "kafka:DescribeCluster",
      "kafka:GetBootstrapBrokers"
    ]

    # TODO: Especificar el ARN del cluster MSK específico
    resources = []
  }
}

# Política para acceso a Redshift - COMPLETAR por el estudiante
data "aws_iam_policy_document" "redshift_access" {
  statement {
    sid = "AllowRedshiftAccess"
    effect = "Allow"

    actions = [
      "redshift:DescribeClusters",
      "redshift:DescribeLoggingStatus"
    ]

    # TODO: Especificar el ARN del cluster Redshift específico
    resources = []
  }
}

# Política para acceso a Glue - COMPLETAR por el estudiante
data "aws_iam_policy_document" "glue_access" {
  statement {
    sid = "AllowGlueOperations"
    effect = "Allow"

    actions = [
      "glue:GetDatabase",
      "glue:GetTables",
      "glue:GetTable",
      "glue:StartCrawler",
      "glue:GetCrawler"
    ]

    resources = ["*"]
  }
}

# Política para CloudWatch Logs - COMPLETAR por el estudiante
data "aws_iam_policy_document" "cloudwatch_logs_access" {
  statement {
    sid = "AllowLogsWrite"
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    # TODO: Especificar los ARNs de los log groups específicos
    resources = []
  }
}

# Política para KMS - COMPLETAR por el estudiante
data "aws_iam_policy_document" "kms_access" {
  statement {
    sid = "AllowKMSDecrypt"
    effect = "Allow"

    actions = [
      "kms:Decrypt",
      "kms:Encrypt",
      "kms:DescribeKey"
    ]

    # TODO: Especificar el ARN de la clave KMS específica
    resources = []
  }
}

# Política para EMR - COMPLETAR por el estudiante
data "aws_iam_policy_document" "emr_access" {
  statement {
    sid = "AllowEMROperations"
    effect = "Allow"

    actions = [
      "elasticmapreduce:*Cluster",
      "elasticmapreduce:DescribeCluster",
      "elasticmapreduce:ListInstances"
    ]

    # TODO: Especificar el ARN del cluster EMR específico
    resources = []
  }
}