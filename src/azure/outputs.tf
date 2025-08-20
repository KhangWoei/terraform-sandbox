output "connection_string"{
    description = "Connection string for the Azure SQL Database"
    sensitive   = true
    value       = "Server=${azurerm_mssql_server.server.fully_qualified_domain_name}, 1433;User Id=${azurerm_mssql_server.server.administrator_login};Password=${azurerm_mssql_server.server.administrator_login_password};TrustServerCertificate=False;Encrypt=True;Connection Timeout=30;"
}