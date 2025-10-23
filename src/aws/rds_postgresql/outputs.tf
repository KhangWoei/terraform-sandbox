output "connection_string" {
  description = "Connection string for the AWS RDS PostgreSQL instance"
  sensitive   = true
  value       = "Host=${aws_db_instance.postgresql.address}, ${aws_db_instance.postgresql.port};Username=${aws_db_instance.postgresql.username};Password=${aws_db_instance.postgresql.password};Database=postgres;"
}
