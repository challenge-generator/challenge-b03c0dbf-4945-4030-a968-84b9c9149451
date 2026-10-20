output "vpc_id" {
  description = "ID de la VPC principal"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "Bloque CIDR de la VPC"
  value       = module.vpc.vpc_cidr_block
}

output "vpc_default_security_group_id" {
  description = "ID del grupo de seguridad por defecto de la VPC"
  value       = module.vpc.default_security_group_id
}

output "public_subnet_ids" {
  description = "IDs de las subredes públicas"
  value       = module.vpc.public_subnets
}

output "private_subnet_ids" {
  description = "IDs de las subredes privadas"
  value       = module.vpc.private_subnets
}

output "database_subnet_ids" {
  description = "IDs de las subredes de base de datos"
  value       = module.vpc.database_subnets
}

output "redshift_subnet_ids" {
  description = "IDs de las subredes para Redshift"
  value       = module.vpc.redshift_subnets
}

output "elasticache_subnet_ids" {
  description = "IDs de las subredes para ElastiCache"
  value       = module.vpc.elasticache_subnets
}

output "intra_subnet_ids" {
  description = "IDs de las subredes intra (sin acceso a internet)"
  value       = module.vpc.intra_subnets
}

output "nat_gateway_ips" {
  description = "IPs de los NAT Gateways"
  value       = module.vpc.nat_gateway_ips
}

output "nat_gateway_ids" {
  description = "IDs de los NAT Gateways"
  value       = module.vpc.nat_gateway_ids
}

output "internet_gateway_id" {
  description = "ID del Internet Gateway"
  value       = module.vpc.igw_id
}

output "public_route_table_ids" {
  description = "IDs de las tablas de rutas públicas"
  value       = module.vpc.public_route_table_ids
}

output "private_route_table_ids" {
  description = "IDs de las tablas de rutas privadas"
  value       = module.vpc.private_route_table_ids
}

output "database_route_table_ids" {
  description = "IDs de las tablas de rutas de base de datos"
  value       = module.vpc.database_route_table_ids
}

output "vpc_primary_cidr_block" {
  description = "Bloque CIDR primario de la VPC"
  value       = module.vpc.vpc_primary_cidr_block
}

output "vpc_secondary_cidr_blocks" {
  description = "Bloques CIDR secundarios de la VPC (CIDR blocks adicionales)"
  value       = module.vpc.vpc_secondary_cidr_blocks
}

output "azs" {
  description = "Zonas de disponibilidad configuradas"
  value       = module.vpc.azs
}

output "name_prefix" {
  description = "Prefijo de nombre usado para los recursos"
  value       = var.name_prefix
}

output "tags" {
  description = "Etiquetas aplicadas a todos los recursos"
  value       = var.tags
}

output "vpc_enable_dns_hostnames" {
  description = "Indica si los hostnames DNS están habilitados"
  value       = module.vpc.enable_dns_hostnames
}

output "vpc_enable_dns_support" {
  description = "Indica si el soporte DNS está habilitado"
  value       = module.vpc.enable_dns_support
}