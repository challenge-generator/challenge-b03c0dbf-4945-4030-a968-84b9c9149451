# =============================================================================
# OUTPUTS DEL MÓDULO DE BIG DATA
# =============================================================================
# Exporta los ARNs, endpoints y configuraciones de los servicios provisionados
# para consumo por otros módulos y para referencia externa.

# Kinesis Outputs
output "kinesis_stream_arn" {
  description = "ARN del Kinesis Data Stream"
  value       = aws_kinesis_stream.main.arn
}

output "kinesis_stream_name" {
  description = "Nombre del Kinesis Data Stream"
  value       = aws_kinesis_stream.main.name
}

output "kinesis_stream_shard_count" {
  description = "Número de shards del stream"
  value       = aws_kinesis_stream.main.shard_count
}

output "kinesis_consumers" {
  description = "Mapa de consumidores de Kinesis"
  value       = aws_kinesis_stream_consumer.analytics_consumer
}

# MSK Outputs
output "msk_cluster_arn" {
  description = "ARN del cluster MSK"
  value       = aws_msk_cluster.main.arn
}

output "msk_cluster_name" {
  description = "Nombre del cluster MSK"
  value       = aws_msk_cluster.main.cluster_name
}

output "msk_bootstrap_brokers_tls" {
  description = "Brokers MSK con TLS"
  value       = aws_msk_cluster.main.bootstrap_brokers_tls
  sensitive   = true
}

output "msk_bootstrap_brokers_sasl_scram" {
  description = "Brokers MSK con SASL SCRAM"
  value       = try(aws_msk_cluster.main.bootstrap_brokers_sasl_scram, null)
  sensitive   = true
}

output "msk_zookeeper_connect_string" {
  description = "Zookeeper connection string"
  value       = aws_msk_cluster.main.zookeeper_connect_string
  sensitive   = true
}

output "msk_security_group_id" {
  description = "ID del security group de MSK"
  value       = aws_security_group.msk.id
}

# EMR Outputs
output "emr_cluster_id" {
  description = "ID del cluster EMR"
  value       = aws_emr_cluster.main.id
}

output "emr_cluster_name" {
  description = "Nombre del cluster EMR"
  value       = aws_emr_cluster.main.name
}

output "emr_master_public_dns" {
  description = "DNS público del nodo master EMR"
  value       = aws_emr_cluster.main.master_public_dns
}

output "emr_master_security_group_id" {
  description = "ID del security group del master EMR"
  value       = aws_security_group.emr_master.id
}

output "emr_slave_security_group_id" {
  description = "ID del security group de los nodos slave EMR"
  value       = aws_security_group.emr_slave.id
}

# Glue Outputs
output "glue_catalog_database_name" {
  description = "Nombre de la base de datos Glue Catalog"
  value       = aws_glue_catalog_database.data_lake.name
}

output "glue_crawlers" {
  description = "Mapa de crawlers Glue"
  value       = aws_glue_crawler.raw_data_crawler
}

output "glue_jobs" {
  description = "Mapa de jobs Glue ETL"
  value       = aws_glue_job.etl_job
}

# Redshift Outputs
output "redshift_cluster_endpoint" {
  description = "Endpoint de conexión al cluster Redshift"
  value       = aws_redshift_cluster.main.endpoint
}

output "redshift_cluster_arn" {
  description = "ARN del cluster Redshift"
  value       = aws_redshift_cluster.main.arn
}

output "redshift_cluster_id" {
  description = "ID del cluster Redshift"
  value       = aws_redshift_cluster.main.id
}

output "redshift_security_group_id" {
  description = "ID del security group de Redshift"
  value       = aws_security_group.redshift.id
}

output "redshift_jdbc_url" {
  description = "URL JDBC de conexión a Redshift"
  value       = "jdbc:redshift://${aws_redshift_cluster.main.endpoint}:${var.redshift_port}/${var.redshift_database_name}"
}

# URLs de servicios para consumo externo
output "service_endpoints" {
  description = "Mapa de endpoints de todos los servicios de Big Data"
  value = {
    kinesis = {
      stream_arn = aws_kinesis_stream.main.arn
      stream_name = aws_kinesis_stream.main.name
    }
    msk = {
      bootstrap_brokers = aws_msk_cluster.main.bootstrap_brokers_tls
      zookeeper = aws_msk_cluster.main.zookeeper_connect_string
    }
    emr = {
      master_dns = aws_emr_cluster.main.master_public_dns
      cluster_id = aws_emr_cluster.main.id
    }
    glue = {
      catalog_database = aws_glue_catalog_database.data_lake.name
    }
    redshift = {
      endpoint = aws_redshift_cluster.main.endpoint
      port     = var.redshift_port
      database = var.redshift_database_name
    }
  }
}