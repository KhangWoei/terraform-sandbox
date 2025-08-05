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
  count      = 2
  vpc_id     = aws_vpc.test_environment.id
  cidr_block = "10.0.${count.index + 1}.0/24"

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

