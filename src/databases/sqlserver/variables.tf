variable "image-version" {
  type    = string
  default = "2022"

}

variable "environment_variables" {
  type = object({
    mssql_sa_password = string
    mssql_pid         = string
  })
  default = {
    mssql_sa_password = "Password@1"
    mssql_pid         = "Developer"
  }
}

variable "ports" {
  type = object({
    internal = number
    external = number
  })
  default = {
    internal = 1433
    external = 1433
  }
}

variable "network-details" {
  type    = object({ name = string })
  default = { name = "" }
}
