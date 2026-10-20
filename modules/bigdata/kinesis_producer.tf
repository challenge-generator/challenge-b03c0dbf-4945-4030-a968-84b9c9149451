data "aws_iam_policy_document" "kinesis_producer_assume" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "kinesis_producer_role" {
  name               = "${var.kinesis_stream_name}-producer-role"
  assume_role_policy = data.aws_iam_policy_document.kinesis_producer_assume.json

  tags = merge(var.common_tags, {
    Name        = "${var.kinesis_stream_name}-producer-role"
    Environment = var.environment
  })
}

data "aws_iam_policy_document" "kinesis_producer_policy" {
  statement {
    effect = "Allow"
    actions = [
      "kinesis:PutRecord",
      "kinesis:PutRecords",
      "kinesis:DescribeStream",
      "kinesis:GetShardIterator"
    ]
    resources = [aws_kinesis_stream.main.arn]
  }

  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["arn:${data.aws_partition.current.partition}:logs:${var.region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${var.kinesis_producer_function_name}*"]
  }

  statement {
    effect = "Allow"
    actions = ["kms:Encrypt", "kms:Decrypt"]
    resources = [var.kinesis_kms_key_arn]
  }
}

resource "aws_iam_policy" "kinesis_producer_policy" {
  name        = "${var.kinesis_stream_name}-producer-policy"
  policy      = data.aws_iam_policy_document.kinesis_producer_policy.json
  description = "IAM policy for Kinesis producer Lambda with least privilege"

  tags = merge(var.common_tags, {
    Name        = "${var.kinesis_stream_name}-producer-policy"
    Environment = var.environment
  })
}

resource "aws_iam_role_policy_attachment" "kinesis_producer_attach" {
  role       = aws_iam_role.kinesis_producer_role.name
  policy_arn = aws_iam_policy.kinesis_producer_policy.arn
}

resource "aws_lambda_function" "kinesis_producer" {
  filename         = var.kinesis_producer_zip_path
  function_name    = var.kinesis_producer_function_name
  role            = aws_iam_role.kinesis_producer_role.arn
  handler          = "index.handler"
  source_code_hash = filebase64sha256(var.kinesis_producer_zip_path)
  runtime          = "python3.11"
  timeout          = var.kinesis_producer_timeout
  memory_size      = var.kinesis_producer_memory_size
  environment {
    variables = {
      STREAM_NAME           = aws_kinesis_stream.main.name
      REGION                = var.region
      BATCH_SIZE            = var.kinesis_producer_batch_size
      MAX_RETRIES           = var.kinesis_producer_max_retries
      LOG_LEVEL             = var.log_level
    }
  }

  vpc_config {
    subnet_ids         = var.private_subnet_ids
    security_group_ids = [var.lambda_security_group_id]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(var.common_tags, {
    Name        = var.kinesis_producer_function_name
    Environment = var.environment
  })
}

resource "aws_cloudwatch_log_group" "kinesis_producer_logs" {
  name              = "/aws/lambda/${var.kinesis_producer_function_name}"
  retention_in_days = var.log_retention_days
  kms_key_id        = var.kinesis_kms_key_arn

  tags = merge(var.common_tags, {
    Name        = "${var.kinesis_producer_function_name}-logs"
    Environment = var.environment
  })
}

resource "aws_lambda_event_source_mapping" "kinesis_producer_source" {
  event_source_arn                   = aws_kinesis_stream.main.arn
  function_name                      = aws_lambda_function.kinesis_producer.arn
  batch_size                         = var.kinesis_producer_batch_size
  starting_position                  = "LATEST"
  destination_config {
    on_failure {
      destination_arn = var.kinesis_dlq_arn
    }
  }
  maximum_record_age_in_seconds     = var.kinesis_max_record_age
  maximum_batching_window_in_seconds = var.kinesis_batching_window
  bisect_batch_on_function_error     = var.kinesis_bisect_on_error
  retry_strategy {
    maximumimum_retry_attempts = var.kinesis_producer_max_retries
  }

  tags = merge(var.common_tags, {
    Name        = "${var.kinesis_stream_name}-producer-mapping"
    Environment = var.environment
  })
}

data "aws_partition" "current" {}

data "aws_caller_identity" "current" {}