variable "chart_version" {
  description = "Versão do chart Helm do ArgoCD"
  type        = string
  default     = "7.7.16"
}

variable "namespace" {
  description = "Namespace do Kubernetes para o ArgoCD"
  type        = string
  default     = "argocd"
}

variable "server_service_type" {
  description = "Tipo do Service do ArgoCD Server (ClusterIP, NodePort, LoadBalancer)"
  type        = string
  default     = "ClusterIP"
}
