locals {
  version = {
    "2022" = "mcr.microsoft.com/mssql/server:2022-latest",
    "2019" = "mcr.microsoft.com/mssql/server:2019-latest",
    "2017" = "mcr.microsoft.com/mssql/server:2017-latest"
  }
  container_name = "sqlserver-${var.image-version}"
}

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {
  host = "npipe:////.//pipe//docker_engine"
}

# SqlServer Database
resource "docker_image" "sqlserver" {
  name = local.version[var.image-version]
}

resource "docker_container" "sqlserver" {
  name  = local.container_name
  image = docker_image.sqlserver.image_id
  ports {
    internal = var.ports.internal
    external = var.ports.external
  }
  env = ["MSSQL_SA_PASSWORD=${var.environment_variables.mssql_sa_password}", "MSSQL_PID=${var.environment_variables.mssql_pid}", "ACCEPT_EULA=Y"]
  networks_advanced {
    name = var.network-details.name
  }
  mounts {
    target = "/var/scripts"
    source = "${path.cwd}/${path.module}/scripts"
    type   = "bind"
  }
  healthcheck {
    test = ["CMD", "/var/scripts/health-check.sh", local.container_name, var.image-version, var.environment_variables.mssql_sa_password]
  }
}

output "connection_string" {
  value = "Data Source=${local.container_name},${var.ports.external};User ID=sa;Password=${var.environment_variables.mssql_sa_password};TrustServerCertificate=True;" 
}
