variable "image-version" {
  type    = string
  default = "17"

}

variable "environment_variables" {
  type = object({
    postgres_password         = string
    postgres_user             = string
    postgres_db               = string
    postgres_initdb_args      = string
    postgres_initdb_waldir    = string
    postgres_host_auth_method = string
    pg_data                   = string
  })
  default = {
    postgres_password         = "Password@1"
    postgres_user             = "postgres"
    postgres_db               = "postgres"
    postgres_initdb_args      = ""
    postgres_initdb_waldir    = ""
    postgres_host_auth_method = "scram-sha-256"
    pg_data                   = "/var/lib/postgresql/data"
  }
}

variable "ports" {
  type = object({
    internal = number
    external = number
  })
  default = {
    internal = 5432
    external = 5432
  }
}

variable "network-details" {
  type    = object({ name = string })
  default = { name = "" }
}
