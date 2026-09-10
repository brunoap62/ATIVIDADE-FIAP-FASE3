variable "project_name" {
  description = "Nome do projeto"
  type        = string
  sensitive   = false
}

variable "cluster_name" {
  description = "Nome do cluster EKS"
  type        = string
  sensitive   = true
}

variable "aws_region" {
  description = "Região AWS padrão"
  type        = string
  sensitive   = true
}

variable "db_username" {
  description = "Usuário master dos bancos PostgreSQL"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Senha master dos bancos PostgreSQL"
  type        = string
  sensitive   = true
}

variable "master_key" {
  description = "Chave mestre de administracao para o auth-service"
  type        = string
  sensitive   = true
}

variable "flag_db_username" {
  description = "Usuário master do banco RDS PostgreSQL do flag-service"
  type        = string
  sensitive   = true
  default     = "flag_user"
}

variable "flag_db_password" {
  description = "Senha master do banco RDS PostgreSQL do flag-service"
  type        = string
  sensitive   = true
  default     = "FlagSecurePass123!"
}