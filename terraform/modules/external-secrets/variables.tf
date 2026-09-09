variable "project_name" {
  description = "Nome do projeto"
  type        = string
}

variable "aws_region" {
  description = "Região AWS padrão"
  type        = string
  default     = "us-east-2"
}

variable "oidc_provider_arn" {
  description = "ARN do provedor OIDC do cluster EKS"
  type        = string
}

variable "oidc_provider_url" {
  description = "URL do provedor OIDC do cluster EKS (sem https:// ou com https://)"
  type        = string
}

variable "namespace" {
  description = "Namespace do Kubernetes onde o External Secrets Operator será instalado"
  type        = string
  default     = "external-secrets"
}

variable "service_account_name" {
  description = "Nome da ServiceAccount utilizada pelo External Secrets Operator"
  type        = string
  default     = "external-secrets-sa"
}

variable "chart_version" {
  description = "Versão do Helm Chart do External Secrets Operator"
  type        = string
  default     = "0.10.4"
}

variable "tags" {
  description = "Tags para os recursos criados pelo módulo"
  type        = map(string)
  default     = {}
}
