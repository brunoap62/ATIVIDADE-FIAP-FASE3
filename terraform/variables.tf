variable "project_name" {
  description = "Nome do projeto"
  type        = string
  default     = "dragonball"
}

variable "cluster_name" {
  description = "Nome do cluster EKS"
  type        = string
  default     = "jojo-eks-cluster"
}

variable "aws_region" {
  description = "Região AWS padrão"
  type        = string
  default     = "us-east-2"
}

variable "db_username" {
  description = "Usuário master dos bancos PostgreSQL"
  type        = string
  default     = "jojoadmin"
}

variable "db_password" {
  description = "Senha master dos bancos PostgreSQL"
  type        = string
  sensitive   = true
  default     = "SenhaSuperSegura123!"
}

variable "master_key" {
  description = "Chave mestre de administracao para o auth-service"
  type        = string
  sensitive   = true
  default     = "admin-secreto-123"
}