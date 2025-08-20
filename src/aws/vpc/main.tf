resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${random_string.suffix.result}"
  }
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${random_string.suffix.result}"
  }
}

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }

  tags = {
    Name = "${random_string.suffix.result}"
    Type = "public"
  }
}

// https://repost.aws/questions/QUB992dLuURtmGzHD_QYQlnw/why-aws-rds-service-needs-two-subnets-from-different-azs
// https://developer.hashicorp.com/terraform/language/meta-arguments/count <-- 0 indexed
resource "aws_subnet" "public_subnets" {
  count             = 2
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.${count.index}.0/24"
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "test-environment-${random_string.suffix.result}"
  }
}

resource "aws_route_table_association" "public_subnet_to_public_route_tables" {
  count          = length(aws_subnet.public_subnet)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_route.id
}

