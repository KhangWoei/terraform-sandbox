resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "test_environment" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "test-environment-${random_string.suffix.result}"
  }
}

resource "aws_internet_gateway" "test_environment_gateway" {
  vpc_id = aws_vpc.test_environment.id

  tags = {
    Name = "test-environment-${random_string.suffix.result}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.test_environment.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test_environment_gateway.id
  }

  tags = {
    Name = "test-environment-${random_string.suffix.result}"
  }
}

// https://repost.aws/questions/QUB992dLuURtmGzHD_QYQlnw/why-aws-rds-service-needs-two-subnets-from-different-azs
// https://developer.hashicorp.com/terraform/language/meta-arguments/count <-- 0 indexed
resource "aws_subnet" "public" {
  count             = 2
  vpc_id            = aws_vpc.test_environment.id
  cidr_block        = "10.0.${count.index}.0/24"
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "test-environment-${random_string.suffix.result}"
  }
}

resource "aws_security_group" "rds" {
  name   = "test_environment_sql_server_rds"
  vpc_id = aws_vpc.test_environment.id

  ingress {
    from_port   = 1433
    to_port     = 1433
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 1433
    to_port     = 1433
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "test-environment-${random_string.suffix.result}"
  }
}

/*
 * RDS specific 
 */
resource "aws_db_subnet_group" "public" {
  name       = "test_environment"
  subnet_ids = aws_subnet.public[*].id

  tags = {
    Name = "test-environment-${random_string.suffix.result}"
  }
}

data "aws_rds_orderable_db_instance" "sqlserver" {
  engine                     = "sqlserver-ex"
  license_model              = "license-included"
  preferred_instance_classes = ["db.t3.large", "db.t3.medium", "db.t3.small"]
  storage_type               = "standard"
}

resource "random_password" "admin_password" {
  count       = var.admin_details.password == null ? 1 : 0
  length      = 20
  special     = true
  min_numeric = 1
  min_upper   = 1
  min_lower   = 1
  min_special = 1

}

resource "aws_db_instance" "sqlserver" {
  identifier = "aws-rds-sqlserver-test-server-${random_string.suffix.result}"
  username   = var.admin_details.username
  password   = try(random_password.admin_password[0].result, var.admin_details.password)

  engine         = data.aws_rds_orderable_db_instance.sqlserver.engine
  engine_version = data.aws_rds_orderable_db_instance.sqlserver.engine_latest_version

  instance_class = data.aws_rds_orderable_db_instance.sqlserver.instance_class

  storage_type      = data.aws_rds_orderable_db_instance.sqlserver.storage_type
  allocated_storage = data.aws_rds_orderable_db_instance.sqlserver.min_storage_size

  db_subnet_group_name   = aws_db_subnet_group.public.name
  multi_az               = false
  vpc_security_group_ids = [aws_security_group.rds.id]

  publicly_accessible = true
  skip_final_snapshot = true

  backup_retention_period = 0

  tags = {
    Name = "test-environment-${random_string.suffix.result}"
  }
}
