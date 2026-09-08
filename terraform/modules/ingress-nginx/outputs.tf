output "namespace" {
  description = "Namespace do Ingress NGINX"
  value       = helm_release.ingress_nginx.namespace
}

output "chart_version" {
  description = "Versão do chart do Ingress NGINX instalado"
  value       = helm_release.ingress_nginx.version
}

output "load_balancer_hostname" {
  description = "Hostname do Load Balancer público gerado na AWS para o Ingress"
  value       = try(data.kubernetes_service.ingress_nginx_controller.status[0].load_balancer[0].ingress[0].hostname, "")
}
