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

resource "docker_image" "test_runner" {
  name = "mcr.microsoft.com/dotnet/sdk:9.0.102-bookworm-slim@sha256:6894a71619e08b47ef9df7ff1f436b21d21db160e5d864e180c294a53d7a12f2"
}

resource "docker_container" "test_runner" {
  name  = "test-runner"
  image = docker_image.test_runner.image_id
  networks_advanced {
    name = var.network-details.name
  }
  mounts {
    target = "/var/scripts"
    source = "${path.cwd}/${path.module}/scripts"
    type   = "bind"
  }
  mounts {
    target = "/var/artifacts"
    source = "${path.cwd}/${path.module}/artifacts"
    type   = "bind"
  }
  mounts {
    target = "/var/outputs"
    source = "${path.cwd}/${path.module}/outputs"
    type   = "bind"
  }
  must_run = true
  command  = ["/var/scripts/run.sh", var.connection-string, "/var/artifacts", "var/outputs"]
}
