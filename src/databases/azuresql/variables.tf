variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
  nullable = false
}
