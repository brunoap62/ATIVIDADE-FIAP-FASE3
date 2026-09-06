# ==============================================================================
# VARIABLES (Parâmetros / Variáveis de Entrada)
# ==============================================================================
# O que são: Pense nas variáveis como os "argumentos/parâmetros" de uma função.
#
# Para que servem:
# 1. Tornar o módulo genérico, dinâmico e reutilizável em múltiplos ambientes.
# 2. Permitir que quem chama o módulo (ex: o root main.tf) customize valores 
#    como nomes, tamanhos, tags e regras sem precisar alterar o código interno.
# ==============================================================================

variable "s3_bucket_name" {
  type        = string
  description = "Nome base do bucket S3 (obrigatório, pois não possui valor default)."
}

variable "s3_tags" {
  type        = map(string)
  default     = {}
  description = "Tags de criação para associar ao bucket S3."
}