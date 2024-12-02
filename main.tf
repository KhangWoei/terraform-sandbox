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

resource "docker_network" "integration_tests" {
  name = "tests"
}

resource "docker_container" "sqlserver" {
  name  = "sqlserver"
  image = docker_image.sqlserver.image_id
  networks_advanced {
    name = docker_network.integration_tests.name
  }
  ports {
    internal = 1443
    external = 1443
  }
  env = ["MSSQL_SA_PASSWORD=P455w07d!"]
}

# Linux machine
resource "docker_image" "ubuntu" {
  name = "ubuntu:latest"
}

resource "docker_container" "test-runner" {
  name     = "test-runner"
  image    = docker_image.ubuntu.image_id
  must_run = false
  networks_advanced {
    name = docker_network.integration_tests.name
  }
}
