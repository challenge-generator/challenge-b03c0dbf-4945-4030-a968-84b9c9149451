resource "aws_kinesis_stream" "main" {
  name             = var.kinesis_stream_name
  shard_count      = var.kinesis_shard_count
  retention_period = var.kinesis_retention_hours
  encryption_type  = "KMS"
  kms_key_id       = var.kinesis_kms_key_arn
  stream_mode_details {
    stream_mode = "PROVISIONED"
  }

  tags = merge(
    var.common_tags,
    {
      Name        = var.kinesis_stream_name
      Description = "Kinesis Data Stream for high-volume transaction processing"
      Component   = "BigData"
      Environment = var.environment
    }
  )
}

resource "aws_kinesis_stream_consumer" "consumer_registration" {
  for_each       = toset(var.kinesis_consumer_arns)
  stream_arn     = aws_kinesis_stream.main.arn
  consumer_name  = each.value
}

resource "aws_cloudwatch_log_group" "kinesis_logs" {
  name              = "/aws/kinesis/${var.kinesis_stream_name}"
  retention_in_days = var.log_retention_days
  kms_key_id        = var.kinesis_kms_key_arn

  tags = merge(var.common_tags, {
    Name        = "${var.kinesis_stream_name}-logs"
    Environment = var.environment
  })
}

resource "aws_cloudwatch_metric_alarm" "iterator_age_alarm" {
  alarm_name          = "${var.kinesis_stream_name}-iterator-age-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "GetRecords.IteratorAgeMilliseconds"
  namespace           = "AWS/Kinesis"
  period              = "300"
  statistic           = "Maximum"
  threshold           = var.kinesis_iterator_age_threshold
  alarm_description   = "This alarm triggers when Kinesis iterator age exceeds threshold"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    StreamName = aws_kinesis_stream.main.name
  }

  tags = merge(var.common_tags, {
    Name        = "${var.kinesis_stream_name}-iterator-age"
    Environment = var.environment
  })
}

resource "aws_cloudwatch_metric_alarm" "write_throughput_alarm" {
  alarm_name          = "${var.kinesis_stream_name}-write-throttle"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "WriteProvisionedThroughputExceeded"
  namespace           = "AWS/Kinesis"
  period              = "300"
  statistic           = "Sum"
  threshold           = "0"
  alarm_description   = "This alarm triggers when Kinesis write is throttled"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    StreamName = aws_kinesis_stream.main.name
  }

  tags = merge(var.common_tags, {
    Name        = "${var.kinesis_stream_name}-write-throttle"
    Environment = var.environment
  })
}

resource "aws_s3_bucket" "kinesis_backup" {
  count  = var.enable_kinesis_backup ? 1 : 0
  bucket = "${var.kinesis_stream_name}-backup-${var.environment}"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = var.kinesis_kms_key_arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  lifecycle_rule {
    enabled = true
    transition {
      days          = 30
      storage_class = "GLACIER"
    }
  }

  tags = merge(var.common_tags, {
    Name        = "${var.kinesis_stream_name}-backup"
    Environment = var.environment
  })
}