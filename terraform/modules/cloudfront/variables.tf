# ==============================================================================
# VARIABLES (Parâmetros / Variáveis de Entrada)
# ==============================================================================
# O que são: Entradas necessárias para construir a distribuição CloudFront.
#
# Para que servem:
# 1. Receber dependências externas (como o ID e o Domain Name do bucket S3).
# 2. Permitir configurações flexíveis (como a classe de preço e tags).
# ==============================================================================

variable "origin_id" {
  type        = string
  description = "Identificador único da origem (ex: ID do bucket S3)."
}

variable "bucket_domain_name" {
  type        = string
  description = "Nome de domínio do endpoint do bucket S3 para onde o CloudFront encaminhará o tráfego."
}

variable "cdn_price_class" {
  type        = string
  default     = "PriceClass_200"
  description = "Classe de preço do CloudFront (define em quais continentes/regiões a CDN terá pontos de presença)."
}

variable "cdn_tags" {
  type        = map(string)
  default     = {}
  description = "Tags para categorização e faturamento da distribuição CDN."
}