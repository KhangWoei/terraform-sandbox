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
    length = 8
    special = false
    upper = false
}

resource "azurerm_mssql_server" "server" {
  name                         = "azuresql-test-server-${random_string.suffix.result}"
  resource_group_name          = var.resource_group.name
  location                     = var.resource_group.location
  administrator_login          = var.admin_username
  administrator_login_password = local.admin_password
  version                      = var.db_version
}
