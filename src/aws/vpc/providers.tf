terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.17.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  profile = var.profile
  region  = var.region
}
