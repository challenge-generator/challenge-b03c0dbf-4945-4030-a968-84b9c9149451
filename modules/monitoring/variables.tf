variable "environment" {
  description = "Nombre del ambiente (dev, qa, prod)"
  type        = string
}

variable "project_name" {
  description = "Nombre del proyecto para identificación de recursos"
  type        = string
}

variable "aws_region" {
  description = "Región de AWS donde se desplegará el módulo de monitoreo"
  type        = string
}

variable "alarm_thresholds" {
  description = "Umbrales de alarmas para métricas críticas del sistema"
  type = object({
    cpu_utilization_high    = number
    cpu_utilization_low     = number
    memory_utilization_high = number
    memory_utilization_low  = number
    disk_utilization_high   = number
    network_in_high         = number
    network_out_high        = number
    latency_p99_high        = number
    error_rate_high         = number
    request_count_threshold = number
  })
}

variable "dashboard_widgets" {
  description = "Configuración de widgets para el dashboard de CloudWatch"
  type = list(object({
    type       = string
    title      = string
    width      = number
    height     = number
    properties = map(any)
  }))
  default = []
}

variable "log_groups" {
  description = "Grupos de logs a monitorear"
  type = list(object({
    name              = string
    retention_days    = number
    kms_key_arn       = optional(string)
    tags              = map(string)
  }))
}

variable "metrics_to_collect" {
  description = "Lista de métricas personalizadas a recopilar"
  type = list(string)
  default = ["CustomMetric1", "CustomMetric2", "CustomMetric3"]
}

variable "alarm_actions" {
  description = "ARNs de SNS para notificaciones de alarmas"
  type        = list(string)
  default     = []
}

variable "ok_actions" {
  description = "ARNs de SNS para notificaciones cuando la alarma se resuelve"
  type        = list(string)
  default     = []
}

variable "evaluation_periods" {
  description = "Número de períodos de evaluación para las alarmas"
  type        = number
  default     = 3
}

variable "period_seconds" {
  description = "Período en segundos para la evaluación de métricas"
  type        = number
  default     = 300
}

variable "datapoints_to_alarm" {
  description = "Número de datapoints que deben violar el umbral para activar la alarma"
  type        = number
  default     = 2
}

variable "treat_missing_data" {
  description = "Cómo tratar los datos faltantes en las métricas"
  type        = string
  default     = "notBreaching"
}

variable "enable_composite_alarm" {
  description = "Habilitar alarma compuesta que agregue múltiples métricas"
  type        = bool
  default     = true
}

variable "composite_alarm_name" {
  description = "Nombre de la alarma compuesta"
  type        = string
  default     = "CompositeAlarm"
}

variable "create_anomaly_detection" {
  description = "Habilitar detección de anomalías para métricas seleccionadas"
  type        = bool
  default     = false
}

variable "anomaly_detection_baseline" {
  description = "Configuración de línea base para detección de anomalías"
  type = object({
    metric_name     = string
    namespace       = string
    stat            = string
    hours_of_data   = number
  })
  default = null
}

variable "tags" {
  description = "Etiquetas personalizadas para recursos de monitoreo"
  type        = map(string)
  default     = {}
}

variable "enable_detailed_monitoring" {
  description = "Habilitar monitoreo detallado para instancias EC2"
  type        = bool
  default     = true
}

variable "monitoring_interval" {
  description = "Intervalo de colección de métricas en segundos"
  type        = number
  default     = 60
}

variable "custom_namespace" {
  description = "Namespace personalizado para métricas de aplicación"
  type        = string
  default     = "CustomApplication"
}

variable "enable_canary_monitoring" {
  description = "Habilitar monitoreo de sinteticos (canaries) para endpoints"
  type        = bool
  default     = false
}

variable "canary_configs" {
  description = "Configuración de canaries de CloudWatch Synthetics"
  type = list(object({
    name           = string
    schedule_type  = string
    schedule_value = string
    runtime_version = string
    timeout_seconds = number
  }))
  default = []
}

variable "enable_insight_rules" {
  description = "Habilitar CloudWatch Application Insights para detección automática de problemas"
  type        = bool
  default     = false
}

variable "insight_rules_resources" {
  description = "Recursos a monitorear con Application Insights"
  type        = list(string)
  default     = []
}