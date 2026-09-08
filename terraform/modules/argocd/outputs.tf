output "namespace" {
  description = "Namespace do ArgoCD"
  value       = helm_release.argocd.namespace
}

output "chart_version" {
  description = "Versão do chart do ArgoCD instalado"
  value       = helm_release.argocd.version
}

output "server_load_balancer_hostname" {
  description = "Hostname do Load Balancer do ArgoCD Server gerado na AWS"
  value       = try(data.kubernetes_service.argocd_server.status[0].load_balancer[0].ingress[0].hostname, "")
}

output "admin_password" {
  description = "Senha inicial do usuário admin do ArgoCD"
  value       = try(nonsensitive(data.kubernetes_secret.argocd_initial_admin_secret.data["password"]), "")
}
