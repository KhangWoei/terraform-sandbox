resource "random_password" "admin_password" {
  count       = var.admin_password == null ? 1 : 0
  length      = 20
  special     = true
  min_numeric = 1
  min_upper   = 1
  min_lower   = 1
  min_special = 1
}

locals {
  admin_password = try(random_password.admin_password[0].result, var.admin_password)
}

resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

resource "azurerm_mssql_server" "server" {
  name                         = "azuresql-test-server-${random_string.suffix.result}"
  resource_group_name          = var.resource_group.name
  location                     = var.resource_group.location
  administrator_login          = var.admin_username
  administrator_login_password = local.admin_password
  version                      = var.db_version
}

resource "azurerm_mssql_database" "database" {
  name         = "azuresql-test-db-${random_string.suffix.result}"
  server_id    = azurerm_mssql_server.server.id
  collation    = "SQL_Latin1_General_CS_AS"
  max_size_gb  = 4
  sku_name     = "S0"
  license_type = "LicenseIncluded"
  geo_backup_enabled = false
}

# Temporary firewall rule to allow all IPs
# Note: This should be replaced with more secure rules in production environments.
resource "azurerm_mssql_firewall_rule" "firewall" {
  name                = "AllowAllIPs" 
  server_id = azurerm_mssql_server.server.id
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}