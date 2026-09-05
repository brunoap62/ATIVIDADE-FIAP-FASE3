variable origin_id {
  type        = string
  description = "The ID of the S3 bucket"
}

variable bucket_domain_name {
  type        = string
  description = "The domain name of the S3 bucket"
}

variable "cdn_price_class" {
  type        = string
  default     = "PriceClass_200"
  description = "Classe de preço do CDN"
}

variable "cdn_tags" {
  type        = map(string)
  default     = {}
  description = "Tags de criação"
}