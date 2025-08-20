data "aws_vpc" "vpc" {
  id = var.vpc_id
}

data "aws_subnets" "public_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }

  filter {
    name   = "tag:Type"
    values = ["*public*"]
  }
}


data "aws_rds_orderable_db_instance" "sqlserver" {
  engine                     = "sqlserver-ex"
  license_model              = "license-included"
  preferred_instance_classes = ["db.t3.large", "db.t3.medium", "db.t3.small"]
  storage_type               = "standard"
}

