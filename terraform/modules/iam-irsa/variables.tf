variable "project_name" {
  description = "Prefixo padrao do projeto"
  type        = string
}

variable "node_role_name" {
  description = "Nome da IAM Role dos nos gerenciados do EKS"
  type        = string
}

variable "sqs_queue_arn" {
  description = "ARN da fila SQS para politicas de envio e consumo"
  type        = string
}

variable "dynamodb_table_arn" {
  description = "ARN da tabela DynamoDB para politica do analytics-service"
  type        = string
}

variable "oidc_provider_arn" {
  description = "ARN do OIDC Provider do cluster EKS"
  type        = string
}

variable "oidc_provider_url" {
  description = "URL do OIDC Provider do cluster EKS"
  type        = string
}
