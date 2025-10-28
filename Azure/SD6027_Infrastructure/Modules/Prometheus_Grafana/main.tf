terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.29"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12"
    }
  }
}

# Tạo namespace cho monitoring
resource "kubernetes_namespace" "monitoring" {

  metadata {
    name = "monitoring"
  }
}

# Cài Prometheus
resource "helm_release" "prometheus" {
  name             = "prometheus"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "prometheus"
  namespace        = kubernetes_namespace.monitoring.metadata[0].name
  create_namespace = false
  version          = "25.16.0"

  values = [
    yamlencode({
      alertmanager = {
        enabled = true
      }
      server = {
        service = {
          type = "LoadBalancer"
        }
      }
    })
  ]
}

# Cài Grafana
resource "helm_release" "grafana" {
  name             = "grafana"
  repository       = "https://grafana.github.io/helm-charts"
  chart            = "grafana"
  namespace        = kubernetes_namespace.monitoring.metadata[0].name
  create_namespace = false
  version          = "8.3.0"

  values = [
    yamlencode({
      adminPassword = "Admin@123"
      service = {
        type = "LoadBalancer"
      }
    })
  ]
}
