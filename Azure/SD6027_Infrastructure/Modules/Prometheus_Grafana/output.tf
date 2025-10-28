output "grafana_service" {
  value = "Run: kubectl get svc -n monitoring"
}

output "prometheus_service" {
  value = "Run: kubectl get svc -n monitoring"
}
