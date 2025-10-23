
data "aws_vpc" "default" {
  count   = var.vpc_id == null ? 1 : 0
  default = true
}

data "aws_vpc" "existing" {
  count = var.vpc_id == null ? 0 : 1
  id    = var.vpc_id
}

locals {
  vpc_id = (var.vpc_id == null) ? data.aws_vpc.default[0].id : data.aws_vpc.existing[0].id
}

data "aws_subnets" "public_subnets" {
  filter {
    name   = "vpc-id"
    values = [local.vpc_id]
  }

  filter {
    name   = "tag:Type"
    values = ["*public*"]
  }
}

data "aws_rds_orderable_db_instance" "postgresql" {
  engine                     = "postgres"
  preferred_instance_classes = ["db.m5.large"]
  storage_type               = "standard"
}

