# Variables para el módulo de cómputo (EKS, auto-scaling, etc.)

variable "eks_cluster_name" {
  description = "Nombre del cluster EKS"
  type        = string
}

variable "eks_cluster_version" {
  description = "Versión de Kubernetes para el cluster EKS"
  type        = string
}

variable "eks_node_instance_type" {
  description = "Tipo de instancia para los nodos del cluster EKS"
  type        = string
}

variable "eks_node_min_size" {
  description = "Número mínimo de nodos en el grupo de auto-scaling"
  type        = number
}

variable "eks_node_max_size" {
  description = "Número máximo de nodos en el grupo de auto-scaling"
  type        = number
}

variable "eks_node_desired_size" {
  description = "Número deseado de nodos en el grupo de auto-scaling"
  type        = number
}

variable "eks_subnet_ids" {
  description = "IDs de las subredes donde se desplegarán los nodos del cluster EKS"
  type        = list(string)
}

variable "eks_cluster_endpoint_private_access" {
  description = "Habilitar acceso privado al endpoint del cluster EKS"
  type        = bool
  default     = true
}

variable "eks_cluster_endpoint_public_access" {
  description = "Habilitar acceso público al endpoint del cluster EKS"
  type        = bool
  default     = false
}

variable "eks_cluster_enabled_log_types" {
  description = "Tipos de logs habilitados para el cluster EKS"
  type        = list(string)
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

variable "tags" {
  description = "Etiquetas comunes para todos los recursos del módulo"
  type        = map(string)
  default     = {}
}