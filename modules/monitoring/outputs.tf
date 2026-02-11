output "namespace" {
  description = "Namespace моніторингу"
  value       = kubernetes_namespace_v1.monitoring.metadata[0].name
}

output "prometheus_service" {
  description = "Сервіс Prometheus"
  value       = "prometheus-server"
}

output "grafana_service" {
  description = "Сервіс Grafana"
  value       = "grafana"
}
