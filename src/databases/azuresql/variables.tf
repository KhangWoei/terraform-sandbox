variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
  nullable = false
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
