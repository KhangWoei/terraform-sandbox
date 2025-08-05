variable "admin_details" {
  type = object({
    username = string
    password = string
  })
  default = {
    username = "awsadmin"
    password = null
  }
}
