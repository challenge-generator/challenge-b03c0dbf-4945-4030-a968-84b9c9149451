# Outputs del módulo de monitoreo
# Expone los recursos creados para consumo por otros módulos

output "log_group_arns" {
  description = "ARNs de los grupos de CloudWatch Logs"
  value       = { for k, v in aws_cloudwatch_log_group.main : k => v.arn }
}

output "log_group_names" {
  description = "Nombres de los grupos de CloudWatch Logs"
  value       = { for k, v in aws_cloudwatch_log_group.main : k => v.name }
}

output "cpu_alarm_arns" {
  description = "ARNs de las alarmas de CPU"
  value       = aws_cloudwatch_metric_alarm.cpu_utilization[*].arn
}

output "memory_alarm_arns" {
  description = "ARNs de las alarmas de memoria"
  value       = aws_cloudwatch_metric_alarm.memory_utilization[*].arn
}

output "disk_alarm_arns" {
  description = "ARNs de las alarmas de disco"
  value       = aws_cloudwatch_metric_alarm.disk_utilization[*].arn
}

output "network_alarm_arns" {
  description = "ARNs de las alarmas de red"
  value       = concat(
    aws_cloudwatch_metric_alarm.network_in[*].arn,
    aws_cloudwatch_metric_alarm.network_out[*].arn
  )
}

output "application_alarm_arns" {
  description = "ARNs de las alarmas de aplicación"
  value       = concat(
    aws_cloudwatch_metric_alarm.latency_high[*].arn,
    aws_cloudwatch_metric_alarm.error_rate_high[*].arn,
    aws_cloudwatch_metric_alarm.request_count_high[*].arn
  )
}

output "asg_alarm_arns" {
  description = "ARNs de las alarmas de auto-scaling"
  value       = concat(
    aws_cloudwatch_metric_alarm.asg_cpu_high[*].arn,
    aws_cloudwatch_metric_alarm.asg_cpu_low[*].arn
  )
}

output "all_alarm_arns" {
  description = "Todos los ARNs de alarmas creadas"
  value       = concat(
    aws_cloudwatch_metric_alarm.cpu_utilization[*].arn,
    aws_cloudwatch_metric_alarm.memory_utilization[*].arn,
    aws_cloudwatch_metric_alarm.disk_utilization[*].arn,
    aws_cloudwatch_metric_alarm.network_in[*].arn,
    aws_cloudwatch_metric_alarm.network_out[*].arn,
    aws_cloudwatch_metric_alarm.latency_high[*].arn,
    aws_cloudwatch_metric_alarm.error_rate_high[*].arn,
    aws_cloudwatch_metric_alarm.request_count_high[*].arn,
    aws_cloudwatch_metric_alarm.asg_cpu_high[*].arn,
    aws_cloudwatch_metric_alarm.asg_cpu_low[*].arn
  )
}

output "dashboard_name" {
  description = "Nombre del dashboard de CloudWatch"
  value       = aws_cloudwatch_dashboard.main.dashboard_name
}

output "dashboard_id" {
  description = "ID del dashboard de CloudWatch"
  value       = aws_cloudwatch_dashboard.main.dashboard_id
}

output "dashboard_arn" {
  description = "ARN del dashboard de CloudWatch"
  value       = aws_cloudwatch_dashboard.main.dashboard_arn
}

output "cloudtrail_arn" {
  description = "ARN del trail de CloudTrail"
  value       = try(aws_cloudtrail.main[0].arn, null)
}

output "cloudtrail_id" {
  description = "ID del trail de CloudTrail"
  value       = try(aws_cloudtrail.main[0].id, null)
}

output "cloudtrail_log_group_arn" {
  description = "ARN del grupo de logs de CloudTrail"
  value       = try(aws_cloudwatch_log_group.cloudtrail[0].arn, null)
}

output "all_cloudwatch_resources" {
  description = "Mapa con todos los recursos de CloudWatch creados"
  value       = {
    log_groups    = { for k, v in aws_cloudwatch_log_group.main : k => { arn = v.arn, name = v.name } }
    alarms_count  = length(concat(aws_cloudwatch_metric_alarm.cpu_utilization[*].arn, aws_cloudwatch_metric_alarm.memory_utilization[*].arn))
    dashboard     = { name = aws_cloudwatch_dashboard.main.dashboard_name, id = aws_cloudwatch_dashboard.main.dashboard_id }
    cloudtrail    = try({ arn = aws_cloudtrail.main[0].arn, id = aws_cloudtrail.main[0].id }, null)
  }
}