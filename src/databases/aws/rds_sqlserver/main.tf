resource "random_password" "admin_password" {
  count       = var.admin_details.password == null ? 1 : 0
  length      = 20
  special     = true
  min_numeric = 1
  min_upper   = 1
  min_lower   = 1
  min_special = 1
}

resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

data "aws_rds_orderable_db_instance" "sqlserver" {
  engine                     = "sqlserver-se"
  engine_latest_version      = true
  license_model              = "amazon-license"
  preferred_instance_classes = ["db.t2.small", "db.t3.small", "db.t2.medium", "db.t3.medium"]
  storage_type               = "standard"
}

resource "aws_db_instance" "sqlserver" {
  identifier     = "aws-rds-sqlserver-test-server-${random_string.suffix.result}"
  engine         = data.aws_rds_orderable_db_instance.sqlserver.engine
  engine_version = data.aws_rds_orderable_db_instance.sqlserver.engine_latest_version
  instance_class = data.aws_rds_orderable_db_instance.sqlserver.instance_class
  storage_type   = data.aws_rds_orderable_db_instance.sqlserver.storage_type

  username            = var.admin_details.user
  password            = random_password.admin_password
  publicly_accessible = true
  skip_final_snapshot = true
}
