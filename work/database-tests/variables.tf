variable "network-details" {
  type    = object({ name = string })
  default = { name = "" }
}

variable "connection-string" {
  type = string
  default = ""
}