# ==============================================================================
# DATA SOURCES (Fontes de Dados / Consultas de Leitura)
# ==============================================================================
# O que são: São consultas de "somente leitura" (Read-Only) à infraestrutura.
#
# Para que servem:
# 1. Buscar informações de recursos que JÁ EXISTEM fora deste código/módulo
#    (ex: buscar uma VPC padrão, um certificado SSL existente, AMI da AWS, etc.).
# 2. O Terraform NÃO cria, altera nem destrói os recursos referenciados em 'data'.
#
# 💡 NOTA DE APRENDIZADO:
# Se o recurso foi criado dentro deste mesmo módulo (em main.tf), não precisamos 
# de um Data Source para ler suas propriedades; podemos referenciá-lo diretamente 
# nos outputs como `aws_s3_bucket.bucket.id` ou `aws_s3_bucket.bucket.bucket_regional_domain_name`.
# ==============================================================================

data "aws_s3_bucket" "bucket" {
  bucket = "${var.s3_bucket_name}-${terraform.workspace}"
}