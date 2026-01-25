# TODO: Argo CD module outputs
# output "namespace" {
#   value = var.namespace
# }

# output "argo_cd_server_service" {
#   description = "Argo CD server service"
#   value       = "argo-cd-argocd-server.${var.namespace}.svc.cluster.local"
# }

# output "admin_password" {
#   description = "Initial admin password command"
#   value       = "Run: kubectl -n ${var.namespace} get secret argocd-initial-admin-secret -o jsonpath={.data.password} | base64 -d"
# }