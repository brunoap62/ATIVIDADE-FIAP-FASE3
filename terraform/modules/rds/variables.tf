variable "project_name" {
  description = "Nome do projeto"
  type        = string
  default     = "togglemaster"
}

variable "vpc_id" {
  description = "ID da VPC"
  type        = string
}

variable "subnet_ids" {
  description = "Subnets privadas para as instâncias RDS"
  type        = list(string)
}

variable "eks_security_group_id" {
  description = "Security Group do EKS para permitir conexões aos bancos"
  type        = string
}

variable "db_instance_class" {
  description = "Tipo de instância do RDS (FinOps Free Tier)"
  type        = string
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "Nome do banco de dados inicial no RDS"
  type        = string
  default     = "auth_db"
}

variable "db_username" {
  description = "Usuário master dos bancos PostgreSQL"
  type        = string
  default     = "togglemaster_admin"
}

variable "db_password" {
  description = "Senha master dos bancos PostgreSQL"
  type        = string
  sensitive   = true
  default     = "minhaSenhaSegura123!"
}
