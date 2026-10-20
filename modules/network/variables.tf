# Variables para el módulo de red (VPC, subredes, NAT gateways, etc.)

variable "vpc_cidr" {
  description = "Bloque CIDR para la VPC principal"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "Lista de bloques CIDR para subredes públicas"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Lista de bloques CIDR para subredes privadas"
  type        = list(string)
}

variable "database_subnet_cidrs" {
  description = "Lista de bloques CIDR para subredes de bases de datos"
  type        = list(string)
}

variable "azs" {
  description = "Lista de zonas de disponibilidad para distribuir subredes"
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Habilitar NAT Gateway para salida a internet desde subredes privadas"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Usar un único NAT Gateway para todas las subredes privadas"
  type        = bool
  default     = true
}

variable "one_nat_gateway_per_az" {
  description = "Crear un NAT Gateway por zona de disponibilidad"
  type        = bool
  default     = false
}

variable "enable_dns_hostnames" {
  description = "Habilitar nombres de host DNS en la VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Habilitar soporte DNS en la VPC"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Etiquetas comunes para todos los recursos del módulo"
  type        = map(string)
  default     = {}
}