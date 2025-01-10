locals {
  network-name = "test"
}


module "network" {
  source = "./network"
  name   = local.network-name
}

module "sqlserver" {
  source          = "./databases/sqlserver"
  network-details = { name = local.network-name }
}

module "postgres" {
  source          = "./databases/postgresql"
  network-details = { name = local.network-name }
}

