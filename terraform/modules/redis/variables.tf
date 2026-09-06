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
  description = "Subnets privadas para o ElastiCache Redis"
  type        = list(string)
}

variable "eks_security_group_id" {
  description = "Security Group do EKS para permitir conexões ao Redis"
  type        = string
}

variable "node_type" {
  description = "Tipo de nó do ElastiCache (Free Tier: cache.t3.micro)"
  type        = string
  default     = "cache.t3.micro"
}

variable "engine_version" {
  description = "Versão do Redis"
  type        = string
  default     = "7.0"
}
