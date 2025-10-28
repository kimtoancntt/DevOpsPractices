variable "name" {
  type = string
  description = "Container Registry name"
}

variable "resource_group_name" {
  type = string
  description = "Resource group name"
}

variable "location" {
  type = string
  description = "Container Registry location"
}

variable "sku" {
    type = string
    description = "SKU variable"
}

variable "tags" {
  type = map(string)
  description = "Container register tags"
}