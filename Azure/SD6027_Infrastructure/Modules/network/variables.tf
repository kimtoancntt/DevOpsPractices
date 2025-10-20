variable "resource_group_name" {
  description = "Name of the resource group that contains the network"
  type        = string
}

variable "location" {
  description = "Azure region for the resources"
  type        = string
}

variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
}

variable "vnet_address_space" {
  description = "IP address range for the Virtual Network"
  type        = list(string)
}

variable "subnet_name" {
  description = "Name of the subnet for AKS"
  type        = string
}

variable "subnet_address_prefix" {
  description = "IP address range for the subnet"
  type        = string
}
