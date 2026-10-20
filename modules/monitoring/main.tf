# Módulo de monitoreo y observabilidad
# Configura CloudWatch, CloudTrail y dashboards para el ecosistema

# --------------------------------------------------------------------------
# Configuración de CloudWatch Logs
# --------------------------------------------------------------------------
resource "aws_cloudwatch_log_group" "main" {
  for_each = var.log_groups

  name              = each.value.name
  retention_in_days = each.value.retention_days
  kms_key_id        = var.kms_key_arn
  tags              = var.common_tags
}

# --------------------------------------------------------------------------
# Métricas personalizadas para la aplicación
# --------------------------------------------------------------------------
resource "aws_cloudwatch_metric_alarm" "cpu_utilization" {
  count               = var.enable_alarms ? var.instance_counts : 0
  alarm_name          = "cpu-utilization-${count.index}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = var.cpu_threshold
  alarm_description   = "Alerta de utilización de CPU"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]
  tags                = var.common_tags

  dimensions = {
    InstanceId = "i-${count.index}"
  }
}

resource "aws_cloudwatch_metric_alarm" "memory_utilization" {
  count               = var.enable_alarms ? var.instance_counts : 0
  alarm_name          = "memory-utilization-${count.index}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "MemoryUtilization"
  namespace           = "CWAgent"
  period              = "300"
  statistic           = "Average"
  threshold           = var.memory_threshold
  alarm_description   = "Alerta de utilización de memoria"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]
  tags                = var.common_tags

  dimensions = {
    InstanceId = "i-${count.index}"
  }
}

resource "aws_cloudwatch_metric_alarm" "disk_utilization" {
  count               = var.enable_alarms ? var.instance_counts : 0
  alarm_name          = "disk-utilization-${count.index}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "DiskSpaceUtilization"
  namespace           = "CWAgent"
  period              = "300"
  statistic           = "Average"
  threshold           = var.disk_threshold
  alarm_description   = "Alerta de utilización de disco"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]
  tags                = var.common_tags

  dimensions = {
    InstanceId = "i-${count.index}",
    path       = "/"
  }
}

resource "aws_cloudwatch_metric_alarm" "network_in" {
  count               = var.enable_alarms ? var.instance_counts : 0
  alarm_name          = "network-in-${count.index}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "NetworkIn"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = var.network_threshold
  alarm_description   = "Alerta de tráfico de entrada"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]
  tags                = var.common_tags

  dimensions = {
    InstanceId = "i-${count.index}"
  }
}

resource "aws_cloudwatch_metric_alarm" "network_out" {
  count               = var.enable_alarms ? var.instance_counts : 0
  alarm_name          = "network-out-${count.index}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "NetworkOut"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = var.network_threshold
  alarm_description   = "Alerta de tráfico de salida"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]
  tags                = var.common_tags

  dimensions = {
    InstanceId = "i-${count.index}"
  }
}

# --------------------------------------------------------------------------
# Alarmas de aplicación (latencia, errores, throughput)
# --------------------------------------------------------------------------
resource "aws_cloudwatch_metric_alarm" "latency_high" {
  count               = var.enable_alarms ? 1 : 0
  alarm_name          = "application-latency-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "Latency"
  namespace           = var.application_namespace
  period              = "60"
  statistic           = "Average"
  threshold           = var.latency_threshold
  alarm_description   = "Alerta de latencia alta"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]
  tags                = var.common_tags
}

resource "aws_cloudwatch_metric_alarm" "error_rate_high" {
  count               = var.enable_alarms ? 1 : 0
  alarm_name          = "application-error-rate-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "Errors"
  namespace           = var.application_namespace
  period              = "60"
  statistic           = "Sum"
  threshold           = var.error_threshold
  alarm_description   = "Alerta de tasa de errores"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]
  tags                = var.common_tags
}

resource "aws_cloudwatch_metric_alarm" "request_count_high" {
  count               = var.enable_alarms ? 1 : 0
  alarm_name          = "application-request-count-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "Requests"
  namespace           = var.application_namespace
  period              = "60"
  statistic           = "Sum"
  threshold           = var.request_count_threshold
  alarm_description   = "Alerta de volumen de solicitudes"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]
  tags                = var.common_tags
}

# --------------------------------------------------------------------------
# Alarmas de auto-scaling
# --------------------------------------------------------------------------
resource "aws_cloudwatch_metric_alarm" "asg_cpu_high" {
  for_each = var.enable_alarms ? var.asg_names : []

  alarm_name          = "asg-cpu-high-${each.value}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/AutoScaling"
  period              = "300"
  statistic           = "Average"
  threshold           = var.asg_cpu_threshold
  alarm_description   = "Escalar hacia arriba por CPU"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]
  tags                = var.common_tags

  dimensions = {
    AutoScalingGroupName = each.value
  }
}

resource "aws_cloudwatch_metric_alarm" "asg_cpu_low" {
  for_each = var.enable_alarms ? var.asg_names : []

  alarm_name          = "asg-cpu-low-${each.value}"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "3"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/AutoScaling"
  period              = "300"
  statistic           = "Average"
  threshold           = var.asg_cpu_low_threshold
  alarm_description   = "Escalar hacia abajo por CPU"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]
  tags                = var.common_tags

  dimensions = {
    AutoScalingGroupName = each.value
  }
}

# --------------------------------------------------------------------------
# CloudTrail para auditoría
# --------------------------------------------------------------------------
resource "aws_cloudtrail" "main" {
  count = var.enable_cloudtrail ? 1 : 0

  name                          = var.cloudtrail_name
  s3_bucket_name                = var.cloudtrail_bucket
  include_global_service_events = true
  is_multi_region_trail         = var.cloudtrail_multi_region
  enable_log_file_validation    = true
  is_organization_trail         = var.is_organization_account
  kms_key_id                    = var.kms_key_arn

  event_selector {
    read_write_type           = "All"
    include_management_events = true
    data_resource {
      type   = "AWS::S3::Object"
      values = ["arn:aws:s3:::"]
    }
  }

  tags = var.common_tags
}

resource "aws_cloudwatch_log_stream" "cloudtrail" {
  count = var.enable_cloudtrail ? 1 : 0

  name           = var.cloudtrail_log_stream_name
  log_group_name = aws_cloudwatch_log_group.cloudtrail[0].name
}

resource "aws_cloudwatch_log_group" "cloudtrail" {
  count = var.enable_cloudtrail ? 1 : 0

  name              = "/aws/cloudtrail/${var.cloudtrail_name}"
  retention_in_days = var.cloudtrail_retention_days
  kms_key_id        = var.kms_key_arn
  tags              = var.common_tags
}

resource "aws_cloudtrail" "cloudtrail_cloudwatch" {
  count = var.enable_cloudtrail ? 1 : 0

  name                          = var.cloudtrail_name
  s3_bucket_name                = var.cloudtrail_bucket
  cloud_watch_logs_group_arn    = aws_cloudwatch_log_group.cloudtrail[0].arn
  cloud_watch_logs_role_arn     = var.cloudtrail_cloudwatch_role_arn
  include_global_service_events = true
  is_multi_region_trail         = var.cloudtrail_multi_region
  enable_log_file_validation    = true
  is_organization_trail         = var.is_organization_account
  kms_key_id                    = var.kms_key_arn

  tags = var.common_tags
}

# --------------------------------------------------------------------------
# Dashboard de CloudWatch
# --------------------------------------------------------------------------
resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = var.dashboard_name

  dashboard_body = jsonencode({
    "widgets" = [
      {
        "type" = "metric"
        "properties" = {
          "title" = "CPU Utilization"
          "metrics" = [
            ["AWS/EC2", "CPUUtilization", "InstanceId", "i-0", {"stat" = "Average"}],
            [".", ".", ".", "i-1", {"stat" = "Average"}],
            [".", ".", ".", "i-2", {"stat" = "Average"}]
          ]
          "period" = 300
          "stat"   = "Average"
          "region" = var.aws_region
          "annotations" = {
            "horizontal" = [
              {"value" = var.cpu_threshold, "label" = "Umbral CPU"}
            ]
          }
        }
      },
      {
        "type" = "metric"
        "properties" = {
          "title" = "Memory Utilization"
          "metrics" = [
            ["CWAgent", "MemoryUtilization", "InstanceId", "i-0", {"stat" = "Average"}],
            [".", ".", ".", "i-1", {"stat" = "Average"}],
            [".", ".", ".", "i-2", {"stat" = "Average"}]
          ]
          "period" = 300
          "stat"   = "Average"
          "region" = var.aws_region
        }
      },
      {
        "type" = "metric"
        "properties" = {
          "title" = "Network Traffic"
          "metrics" = [
            ["AWS/EC2", "NetworkIn", "InstanceId", "i-0", {"stat" = "Average"}],
            [".", "NetworkOut", ".", "i-0", {"stat" = "Average"}],
            [".", ".", ".", "i-1", {"stat" = "Average"}],
            [".", ".", ".", "i-1", {"stat" = "Average"}]
          ]
          "period" = 300
          "stat"   = "Average"
          "region" = var.aws_region
        }
      },
      {
        "type" = "metric"
        "properties" = {
          "title" = "Application Latency"
          "metrics" = [
            [var.application_namespace, "Latency", {"stat" = "Average"}],
            [var.application_namespace, "Latency", {"stat" = "Maximum"}]
          ]
          "period" = 60
          "stat"   = "Average"
          "region" = var.aws_region
        }
      },
      {
        "type" = "metric"
        "properties" = {
          "title" = "Application Errors"
          "metrics" = [
            [var.application_namespace, "Errors", {"stat" = "Sum"}],
            [var.application_namespace, "Requests", {"stat" = "Sum"}]
          ]
          "period" = 60
          "stat"   = "Sum"
          "region" = var.aws_region
        }
      },
      {
        "type" = "metric"
        "properties" = {
          "title" = "Disk Usage"
          "metrics" = [
            ["CWAgent", "DiskSpaceUtilization", "InstanceId", "i-0", "path", "/", {"stat" = "Average"}],
            [".", ".", ".", "i-1", ".", ".", {"stat" = "Average"}],
            [".", ".", ".", "i-2", ".", ".", {"stat" = "Average"}]
          ]
          "period" = 300
          "stat"   = "Average"
          "region" = var.aws_region
        }
      }
    ]
  })
}