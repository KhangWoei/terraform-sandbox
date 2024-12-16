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
  name = "mcr.microsoft.com/mssql/server:2022-latest"
}

resource "docker_container" "sqlserver" {
  name  = "sqlserver"
  image = docker_image.sqlserver.image_id
  ports {
    internal = var.ports.internal
    external = var.ports.external
  }
  env = ["MSSQL_SA_PASSWORD=${var.environment_variables.mssql_sa_password}", "MSSQL_PID=${var.environment_variables.mssql_pid}"]
  networks_advanced {
    name = var.network-details.name
  }
}

