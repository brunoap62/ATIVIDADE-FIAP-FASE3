output "namespace" {
  description = "Namespace do ArgoCD"
  value       = helm_release.argocd.namespace
}

output "chart_version" {
  description = "Versão do chart do ArgoCD instalado"
  value       = helm_release.argocd.version
}
