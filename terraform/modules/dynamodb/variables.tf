variable "table_name" {
  description = "Nome da tabela DynamoDB"
  type        = string
  default     = "ToggleMasterAnalytics"
}

variable "billing_mode" {
  description = "Modo de cobrança da tabela (PAY_PER_REQUEST ou PROVISIONED)"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "hash_key" {
  description = "Chave de partição (Partition Key)"
  type        = string
  default     = "event_id"
}
