resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

resource "aws_security_group" "rds_sqlserver_security_group" {
  name   = "rds-sqlserver-security-group-${random_string.suffix.result}"
  vpc_id = data.aws_vpc.vpc.id

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
    Name = "rds-sqlserver-${random_string.suffix.result}"
  }
}

/*
 * RDS specific 
 */
resource "aws_db_subnet_group" "public" {
  name       = "rds-sqlserver-db-subnet-group-${random_string.suffix.result}"
  subnet_ids = data.aws_subnets.public_subnets.ids

  tags = {
    Name = "rds-sqlserver-${random_string.suffix.result}"
  }
}

resource "random_password" "admin_password" {
  count            = var.admin_details.password == null ? 1 : 0
  length           = 20
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
  min_numeric      = 1
  min_upper        = 1
  min_lower        = 1
  min_special      = 1

}

resource "aws_db_instance" "sqlserver" {
  identifier = "rds-sqlserver-${random_string.suffix.result}"
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
    Name = "rds-sqlserver-${random_string.suffix.result}"
  }
}
