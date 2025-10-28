variable "client_secret" {
  type = string
  description = "The register app client secret"
}

variable "tenant_id" {
  type = string
  description = "The tenant id of the Azure Active Directory"
}

variable "subscription_id" {
  type = string
  description = "The subscription id of the Azure Subscription"
}

variable "client_id" {
  type = string
  description = "The client id of the registered app in Azure Active Directory"
}

variable "location" {
  type        = string
  description = "The Azure region to deploy resources in"
  default     = "East US"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group to create"
  default     = "rg_sd6027"

}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the resource group"
  default     = {
    Environment = "Dev"
    Project     = "SD6027"
  }
}

# Container Registry Variables
variable "container_registry_name" {
  type        = string
  description = "The name of the Container Registry to create"
  default     = "acrsd6027dev"
}

variable "container_registry_sku" {
  type        = string
  description = "The SKU of the Container Registry"
  default     = "Basic"
}

# Network Variables
variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
  default     = "aks-dev-vnet"
}

variable "vnet_address_space" {
  description = "IP address range for the Virtual Network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_name" {
  description = "Name of the subnet for AKS"
  type        = string
  default     = "aks-subnet"
}

variable "subnet_address_prefix" {
  description = "IP address range for the subnet"
  type        = string
  default     = "10.0.1.0/24"
}

# Kubernetes Service Variables
variable "cluster_name" {
  type    = string
  default = "aks-sd6027-dev-cluster"
}

variable "dns_prefix" {
  type    = string
  default = "aksdev"
}

variable "node_pool_name" {
  type    = string
  default = "devpool"
}

variable "node_count" {
  type    = number
  default = 1
}

variable "vm_size" {
  type    = string
  default = "Standard_B2s"
}

variable "kubernetes_version" {
  type    = string
  default = "1.33.3"
}
