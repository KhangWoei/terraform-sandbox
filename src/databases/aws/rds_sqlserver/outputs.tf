output "connection_string" {
  description = "Connection string for the AWS RDS SqlServer Database"
  sensitive   = true
  value       = "Server=${aws_db_instance.sqlserver.domain}, ${aws_db_instance.sqlserver.port};User Id=${aws_db_instance.sqlserver.username};Password=${aws_db_instance.sqlserver.password};TrustServerCertificate=False;Connection Timeout=30;"
}
