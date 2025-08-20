variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
  nullable = false
}

variable "db_version" {
  type    = string
  default = "12.0"

  validation {
    condition = contains(["2.0", "12.0"], var.db_version)
    error_message = "Version must be either '2.0' or '12.0'."
  }
}

variable "admin_username" {
  type    = string
  default = "azureadmin"
}

variable "admin_password" {
  type      = string
  sensitive = true
  default   = null
}
