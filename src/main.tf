locals {
  network-name = "test"
}

module "network" {
  source = "./network"
  name   = local.network-name
}

module "database" {
  source          = "./databases/postgresql"
  network-details = { name = local.network-name }
}

module "database-test-runner" {
  source          = "./work/database-tests"
  network-details = { name = local.network-name }
  connection-string = module.database.connection_string
}

