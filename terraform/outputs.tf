# ==============================================================================
# OUTPUTS (Valores de Saída)
# ==============================================================================
# O que são: Pense nos outputs como o comando 'return' de uma função.
#
# Para que servem:
# 1. Exibir informações úteis no terminal após a execução do `terraform apply` 
#    (ex: URLs geradas, IPs públicos, nomes de recursos).
# 2. Permitir que outros sistemas, scripts de CI/CD ou outros módulos consultem esses dados.
# ==============================================================================

output "s3_bucket_name" {
  value       = module.s3.bucket_domain_name
  sensitive   = false
  description = "The name of the S3 bucket that is used to store the static website content."
}

output "cdn_domain" {
  value       = module.cloudfront.cdn_domain_name
  sensitive   = false
  description = "The domain name corresponding to the CDN distribution."
}

    output "ecr_repository_urls" {
      value       = module.ecr.repository_urls
      description = "URLs dos repositórios ECR criados"
    }
  
    output "ecr_repository_arns" {
      value       = module.ecr.repository_arns
      description = "ARNs dos repositórios ECR criados"
    }