locals {
  version = {
    "latest" = "mcr.microsoft.com/mssql/server:2022-latest"
  }
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
  name  = "sqlserver-${var.image-version}"
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
    source = "E:/Projects/terraform-sandbox/databases/sqlserver/scripts"
    type   = "bind"
  }
  healthcheck {
    test = ["CMD", "/var/scripts/health-check.sh"]
  }
}

