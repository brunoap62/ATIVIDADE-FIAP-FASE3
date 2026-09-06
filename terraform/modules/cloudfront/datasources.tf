# ==============================================================================
# DATA SOURCES (Fontes de Dados / Consultas de Leitura)
# ==============================================================================
# O que são: Consultas para ler dados de recursos já existentes na nuvem.
#
# 💡 NOTA DE APRENDIZADO:
# Da mesma forma que no S3, como `aws_cloudfront_distribution.cloudfront` foi 
# criado neste mesmo módulo (em main.tf), poderíamos ler seus atributos 
# (como domain_name e id) diretamente do recurso, sem precisar desta consulta data.
# ==============================================================================

data "aws_cloudfront_distribution" "cloudfront" {
  id = aws_cloudfront_distribution.cloudfront.id
}