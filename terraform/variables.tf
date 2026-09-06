variable "project_name" {
  description = "Nome do projeto"
  type        = string
  default     = "jojo-adventure"
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