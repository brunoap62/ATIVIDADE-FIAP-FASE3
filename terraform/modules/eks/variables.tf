variable "project_name" {
  description = "Nome do projeto"
  type        = string
  default     = "togglemaster"
}

variable "cluster_name" {
  description = "Nome do cluster EKS"
  type        = string
  default     = "togglemaster-cluster"
}

variable "cluster_version" {
  description = "Versão do Kubernetes para o EKS"
  type        = string
  default     = "1.31"
}

variable "vpc_id" {
  description = "ID da VPC onde o cluster será criado"
  type        = string
}

variable "subnet_ids" {
  description = "Subnets para o control plane e node groups do EKS (privadas recomendadas)"
  type        = list(string)
}

variable "node_instance_types" {
  description = "Tipos de instância para o Node Group (FinOps/Free Tier)"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "desired_size" {
  description = "Número desejado de nós no Node Group"
  type        = number
  default     = 2
}

variable "min_size" {
  description = "Número mínimo de nós no Node Group"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Número máximo de nós no Node Group"
  type        = number
  default     = 4
}
