variable "repository_names" {
  description = "Lista dos nomes de repositórios ECR para os microsserviços"
  type        = list(string)
}

variable "image_tag_mutability" {
  description = "Mutabilidade das tags das imagens (MUTABLE ou IMMUTABLE)"
  type        = string
  default     = "MUTABLE"
}
