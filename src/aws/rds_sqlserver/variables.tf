variable "profile" {
  type    = string
  default = null
}

variable "region" {
  type    = string
  default = "eu-west-1"
}

variable "vpc_id" {
  type    = string
  default = null
}

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

