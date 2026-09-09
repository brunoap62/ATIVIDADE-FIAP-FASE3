output "namespace" {
  description = "Namespace do Ingress NGINX"
  value       = helm_release.ingress_nginx.namespace
}

output "chart_version" {
  description = "Versão do chart do Ingress NGINX instalado"
  value       = helm_release.ingress_nginx.version
}
