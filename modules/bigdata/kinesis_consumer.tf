data "aws_iam_policy_document" "kinesis_consumer_assume" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "kinesis_consumer_role" {
  name               = "${var.kinesis_stream_name}-consumer-role"
  assume_role_policy = data.aws_iam_policy_document.kinesis_consumer_assume.json

  tags = merge(var.common_tags, {
    Name        = "${var.kinesis_stream_name}-consumer-role"
    Environment = var.environment
  })
}

data "aws_iam_policy_document" "kinesis_consumer_policy" {
  statement {
    effect = "Allow"
    actions = [
      "kinesis:GetRecords",
      "kinesis:GetShardIterator",
      "kinesis:DescribeStream",
      "kinesis:ListShards"
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
    resources = ["arn:${data.aws_partition.current.partition}:logs:${var.region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${var.kinesis_consumer_function_name}*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem",
      "dynamodb:Query",
      "dynamodb:Scan"
    ]
    resources = [var.dynamodb_table_arn]
  }

  statement {
    effect = "Allow"
    actions = [
      "sqs:SendMessage",
      "sqs:ReceiveMessage",
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes"
    ]
    resources = [var.kinesis_dlq_arn]
  }

  statement {
    effect = "Allow"
    actions = ["kms:Encrypt", "kms:Decrypt", "kms:GenerateDataKey"]
    resources = [var.kinesis_kms_key_arn]
  }
}

resource "aws_iam_policy" "kinesis_consumer_policy" {
  name        = "${var.kinesis_stream_name}-consumer-policy"
  policy      = data.aws_iam_policy_document.kinesis_consumer_policy.json
  description = "IAM policy for Kinesis consumer Lambda with least privilege"

  tags = merge(var.common_tags, {
    Name        = "${var.kinesis_stream_name}-consumer-policy"
    Environment = var.environment
  })
}

resource "aws_iam_role_policy_attachment" "kinesis_consumer_attach" {
  role       = aws_iam_role.kinesis_consumer_role.name
  policy_arn = aws_iam_policy.kinesis_consumer_policy.arn
}

resource "aws_lambda_function" "kinesis_consumer" {
  filename         = var.kinesis_consumer_zip_path
  function_name    = var.kinesis_consumer_function_name
  role            = aws_iam_role.kinesis_consumer_role.arn
  handler          = "index.handler"
  source_code_hash = filebase64sha256(var.kinesis_consumer_zip_path)
  runtime          = "python3.11"
  timeout          = var.kinesis_consumer_timeout
  memory_size      = var.kinesis_consumer_memory_size
  environment {
    variables = {
      STREAM_NAME              = aws_kinesis_stream.main.name
      REGION                   = var.region
      DYNAMODB_TABLE_NAME      = var.dynamodb_table_name
      DLQ_URL                  = var.kinesis_dlq_url
      BATCH_SIZE               = var.kinesis_consumer_batch_size
      MAX_CONCURRENT_BATCHES   = var.kinesis_max_concurrent_batches
      LOG_LEVEL                = var.log_level
      ENABLE_DLQ               = var.enable_dlq_for_failed_messages
      PROCESSING_ERROR_SNS_ARN = var.sns_topic_arn
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
    Name        = var.kinesis_consumer_function_name
    Environment = var.environment
  })
}

resource "aws_cloudwatch_log_group" "kinesis_consumer_logs" {
  name              = "/aws/lambda/${var.kinesis_consumer_function_name}"
  retention_in_days = var.log_retention_days
  kms_key_id        = var.kinesis_kms_key_arn

  tags = merge(var.common_tags, {
    Name        = "${var.kinesis_consumer_function_name}-logs"
    Environment = var.environment
  })
}

resource "aws_lambda_event_source_mapping" "kinesis_consumer_source" {
  event_source_arn                   = aws_kinesis_stream.main.arn
  function_name                      = aws_lambda_function.kinesis_consumer.arn
  batch_size                         = var.kinesis_consumer_batch_size
  starting_position                  = "LATEST"
  destination_config {
    on_failure {
      destination_arn = var.kinesis_dlq_arn
    }
  }
  maximum_record_age_in_seconds      = var.kinesis_max_record_age
  maximum_batching_window_in_seconds = var.kinesis_batching_window
  bisect_batch_on_function_error     = var.kinesis_bisect_on_error
  parallelization_factor             = var.kinesis_parallelization_factor
  retry_strategy {
    maximum_retry_attempts = var.kinesis_consumer_max_retries
  }

  tags = merge(var.common_tags, {
    Name        = "${var.kinesis_stream_name}-consumer-mapping"
    Environment = var.environment
  })
}

resource "aws_cloudwatch_metric_alarm" "consumer_errors_alarm" {
  alarm_name          = "${var.kinesis_consumer_function_name}-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "Errors"
  namespace           = "AWS/Lambda"
  period              = "300"
  statistic           = "Sum"
  threshold           = var.kinesis_consumer_error_threshold
  alarm_description   = "This alarm triggers when Kinesis consumer Lambda has errors"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    FunctionName = aws_lambda_function.kinesis_consumer.function_name
  }

  tags = merge(var.common_tags, {
    Name        = "${var.kinesis_consumer_function_name}-errors"
    Environment = var.environment
  })
}

resource "aws_cloudwatch_metric_alarm" "consumer_duration_alarm" {
  alarm_name          = "${var.kinesis_consumer_function_name}-duration"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "3"
  metric_name         = "Duration"
  namespace           = "AWS/Lambda"
  period              = "300"
  statistic           = "Maximum"
  threshold           = var.kinesis_consumer_duration_threshold
  alarm_description   = "This alarm triggers when Kinesis consumer Lambda duration exceeds threshold"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    FunctionName = aws_lambda_function.kinesis_consumer.function_name
  }

  tags = merge(var.common_tags, {
    Name        = "${var.kinesis_consumer_function_name}-duration"
    Environment = var.environment
  })
}

resource "aws_cloudwatch_metric_alarm" "dlq_messages_alarm" {
  count               = var.enable_dlq_for_failed_messages ? 1 : 0
  alarm_name          = "${var.kinesis_stream_name}-dlq-messages"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "ApproximateNumberOfMessagesVisible"
  namespace           = "AWS/SQS"
  period              = "300"
  statistic           = "Maximum"
  threshold           = var.dlq_message_threshold
  alarm_description   = "This alarm triggers when there are messages in the Kinesis DLQ"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    QueueName = var.kinesis_dlq_name
  }

  tags = merge(var.common_tags, {
    Name        = "${var.kinesis_stream_name}-dlq-alarm"
    Environment = var.environment
  })
}