# ==============================================================================
# OUTPUTS DO MÓDULO (Exportação de Dados para o Módulo Pai)
# ==============================================================================
# O que são: Valores de retorno exportados por este módulo.
#
# Para que servem:
# 1. Disponibilizar o domínio gerado pela CDN (ex: d111111abcdef8.cloudfront.net) 
#    e o ID da distribuição para o módulo raiz.
# 2. O módulo raiz pode então exibir esse domínio no terminal para que você saiba 
#    qual URL acessar no seu navegador para testar o site.
# ==============================================================================

  output "cdn_domain_name" {                                                                                                                               
      value       = aws_cloudfront_distribution.cloudfront.domain_name                                                                                       
      sensitive   = false                                                                                                                                    
      description = "The domain name corresponding to the distribution, e.g., d111111abcdef8.cloudfront.net"                                                 
    }
  
    output "cdn_id" {
      value       = aws_cloudfront_distribution.cloudfront.id
      sensitive   = false
      description = "The distribution ID that uniquely identifies the distribution."
    }