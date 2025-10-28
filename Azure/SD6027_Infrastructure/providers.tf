terraform {
  required_version = ">= 1.9.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.49.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.30"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

# Provider cho Kubernetes
provider "kubernetes" {
  alias                  = "aks"
  host                   = module.kubernetes_service.kube_config.host
  client_certificate     = base64decode(module.kubernetes_service.kube_config.client_certificate)
  client_key             = base64decode(module.kubernetes_service.kube_config.client_key)
  cluster_ca_certificate = base64decode(module.kubernetes_service.kube_config.cluster_ca_certificate)
}

# Provider cho Helm
provider "helm" {
  alias = "aks"

  kubernetes {
    host                   = module.kubernetes_service.kube_config.host
    client_certificate     = base64decode(module.kubernetes_service.kube_config.client_certificate)
    client_key             = base64decode(module.kubernetes_service.kube_config.client_key)
    cluster_ca_certificate = base64decode(module.kubernetes_service.kube_config.cluster_ca_certificate)
  }
}
