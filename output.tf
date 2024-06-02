output "endpoint" {
  description = "Endpoint for the Kubernetes API server"
  value       = kind_cluster.default.endpoint
}
