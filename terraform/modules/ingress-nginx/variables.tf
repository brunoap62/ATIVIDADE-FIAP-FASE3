variable "chart_version" {
  description = "Versão do chart Helm do Ingress NGINX"
  type        = string
  default     = "4.12.0"
}

variable "namespace" {
  description = "Namespace do Kubernetes para o Ingress NGINX"
  type        = string
  default     = "ingress-nginx"
}
