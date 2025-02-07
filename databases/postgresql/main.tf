locals {
  version = {
    "17" = "postgres:17",
    "16" = "postgres:16",
    "15" = "postgres:15"
  }
  container_name = "postgres-${var.image-version}"
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

resource "docker_image" "postgres" {
  name = local.version[var.image-version]
}

resource "docker_container" "postgres" {
  name  = local.container_name
  image = docker_image.postgres.image_id
  ports {
    internal = var.ports.internal
    external = var.ports.external
  }
  env = ["POSTGRES_USER=${var.environment_variables.postgres_user}", "POSTGRES_PASSWORD=${var.environment_variables.postgres_password}", "POSTGRES_DB=${var.environment_variables.postgres_db}", "POSTGRES_INITDB_ARGS=${var.environment_variables.postgres_initdb_args}", "POSTGRES_INITDB_WALDIR=${var.environment_variables.postgres_initdb_waldir}", "POSTGRES_HOST_AUTH_METHOD=${var.environment_variables.postgres_host_auth_method}", "PG_DATA=${var.environment_variables.pg_data}"]
  networks_advanced {
    name = var.network-details.name
  }
  mounts {
    target = "/var/scripts"
    source = "${path.cwd}/${path.module}/scripts"
    type   = "bind"
  }
  healthcheck {
    test = ["CMD", "/var/scripts/health-check.sh", var.environment_variables.postgres_user]
  }
}

output "connection_string" {
  value = "Host=${local.container_name},${var.ports.external};User ID=${var.environment_variables.postgres_user};Password=${var.environment_variables.postgres_password};Database=postgres"
}