# ==============================================================================
# OUTPUTS DO MÓDULO (Exportação de Dados para o Módulo Pai)
# ==============================================================================
# O que são: Valores que este módulo disponibiliza publicamente para quem o invocar.
#
# Para que servem:
# 1. Permitir que o 'main.tf' raiz receba os valores gerados aqui (como o ID e Domain Name)
#    e possa repassá-los para outros módulos (ex: passar `module.s3.bucket_id` para o CloudFront).
# 2. Sem os outputs no módulo filho, o módulo pai não tem como acessar o que foi criado aqui.
# ==============================================================================

output "bucket_domain_name" {
  # value       = data.aws_s3_bucket.bucket.bucket_domain_name  ASSIM BUSCA DENTRO DO MÓDULO (Data Source) --- IGNORE ---
  value       = aws_s3_bucket.bucket.bucket_domain_name
  sensitive   = false
  description = "The domain name of the S3 bucket"
}

output "bucket_id" {
  value       = aws_s3_bucket.bucket.id
  sensitive   = false
  description = "The ID of the S3 bucket"
}