# ==============================================================================
# OUTPUTS GERAIS (Valores de Saída da Infraestrutura)
# ==============================================================================

# ------------------------------------------------------------------------------
# 1. Rede (VPC e Subnets)
# ------------------------------------------------------------------------------
output "vpc_id" {
  description = "ID da VPC criada"
  value       = module.network.vpc_id
}

output "public_subnet_ids" {
  description = "IDs das subnets públicas"
  value       = module.network.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs das subnets privadas"
  value       = module.network.private_subnet_ids
}

output "vpc_cidr" {
  description = "Bloco CIDR da VPC"
  value       = module.network.vpc_cidr
}

# ------------------------------------------------------------------------------
# 2. Kubernetes (EKS)
# ------------------------------------------------------------------------------
output "eks_cluster_name" {
  description = "Nome do cluster EKS"
  value       = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  description = "Endpoint da API do cluster EKS para conexão kubectl"
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_security_group_id" {
  description = "ID do Security Group do Cluster EKS"
  value       = module.eks.cluster_security_group_id
}

output "eks_oidc_provider_arn" {
  description = "ARN do provedor OIDC para autenticação IRSA"
  value       = module.eks.oidc_provider_arn
}

# ------------------------------------------------------------------------------
# 3. Cache & Mensageria (ElastiCache Redis & SQS) [COMENTADO]
# ------------------------------------------------------------------------------
# output "redis_endpoint" {
#   description = "Endpoint do cluster ElastiCache Redis"
#   value       = module.redis.redis_endpoint
# }
# 
# output "redis_port" {
#   description = "Porta de conexão do cluster Redis"
#   value       = module.redis.redis_port
# }
# 
# output "sqs_queue_url" {
#   description = "URL da fila SQS criada"
#   value       = module.sqs.queue_id
# }
# 
# output "sqs_queue_arn" {
#   description = "ARN da fila SQS criada"
#   value       = module.sqs.queue_arn
# }

# ------------------------------------------------------------------------------
# 4. Bancos de Dados Relacionais Dedicados (RDS PostgreSQL - 100% Free Tier)
# ------------------------------------------------------------------------------
# --- Banco RDS PostgreSQL Dedicado (auth-service / auth_db) ---
output "auth_rds_endpoint" {
  description = "Endpoint completo de conexão do banco RDS PostgreSQL do auth-service"
  value       = module.auth_rds.db_endpoint
}

output "auth_rds_address" {
  description = "Host do banco RDS PostgreSQL do auth-service"
  value       = module.auth_rds.db_address
}

output "auth_rds_port" {
  description = "Porta do banco RDS PostgreSQL do auth-service"
  value       = module.auth_rds.db_port
}

output "auth_rds_database_name" {
  description = "Nome do banco de dados inicial no RDS do auth-service"
  value       = module.auth_rds.db_name
}

# --- Banco RDS PostgreSQL Dedicado (flag-service / flag_db) ---
output "flag_rds_endpoint" {
  description = "Endpoint completo de conexão do banco RDS PostgreSQL do flag-service"
  value       = module.flag_rds.db_endpoint
}

output "flag_rds_address" {
  description = "Host do banco RDS PostgreSQL do flag-service"
  value       = module.flag_rds.db_address
}

output "flag_rds_port" {
  description = "Porta do banco RDS PostgreSQL do flag-service"
  value       = module.flag_rds.db_port
}

output "flag_rds_database_name" {
  description = "Nome do banco de dados inicial no RDS do flag-service"
  value       = module.flag_rds.db_name
}

# --- Banco RDS PostgreSQL Dedicado (targeting-service / targeting_db) ---
output "targeting_rds_endpoint" {
  description = "Endpoint completo de conexão do banco RDS PostgreSQL do targeting-service"
  value       = module.targeting_rds.db_endpoint
}

output "targeting_rds_address" {
  description = "Host do banco RDS PostgreSQL do targeting-service"
  value       = module.targeting_rds.db_address
}

output "targeting_rds_port" {
  description = "Porta do banco RDS PostgreSQL do targeting-service"
  value       = module.targeting_rds.db_port
}

output "targeting_rds_database_name" {
  description = "Nome do banco de dados inicial no RDS do targeting-service"
  value       = module.targeting_rds.db_name
}

# ------------------------------------------------------------------------------
# 4. Cache em Memória (AWS ElastiCache Redis)
# ------------------------------------------------------------------------------
output "redis_endpoint" {
  description = "Endpoint do cluster ElastiCache Redis"
  value       = module.redis.redis_endpoint
}

output "redis_port" {
  description = "Porta do cluster ElastiCache Redis"
  value       = module.redis.redis_port
}

# ------------------------------------------------------------------------------
# 5. Mensageria Assíncrona (AWS SQS)
# ------------------------------------------------------------------------------
output "sqs_queue_url" {
  description = "URL da fila SQS para o evaluation-service"
  value       = module.sqs.queue_id
}

output "sqs_queue_arn" {
  description = "ARN da fila SQS para o evaluation-service"
  value       = module.sqs.queue_arn
}

# ------------------------------------------------------------------------------
# 6. Banco de Dados NoSQL (DynamoDB) [COMENTADO]
# ------------------------------------------------------------------------------
# output "dynamodb_table_name" {
#   description = "Nome da tabela DynamoDB para analytics"
#   value       = module.dynamodb.table_name
# }
# 
# output "dynamodb_table_arn" {
#   description = "ARN da tabela DynamoDB para analytics"
#   value       = module.dynamodb.table_arn
# }

# ------------------------------------------------------------------------------
# 7. Storage & Registro de Containers (S3 [COMENTADO] & ECR)
# ------------------------------------------------------------------------------
# output "s3_bucket_name" {
#   description = "Nome do bucket S3"
#   value       = module.s3.bucket_domain_name
# }
# 
# output "s3_bucket_id" {
#   description = "ID do bucket S3"
#   value       = module.s3.bucket_id
# }

output "ecr_repository_urls" {
  description = "URLs dos repositórios ECR criados"
  value       = module.ecr.repository_urls
}

output "ecr_repository_arns" {
  description = "ARNs dos repositórios ECR criados"
  value       = module.ecr.repository_arns
}

# ------------------------------------------------------------------------------
# 7. GitOps & CI/CD (ArgoCD)
# ------------------------------------------------------------------------------
output "argocd_namespace" {
  description = "Namespace do ArgoCD"
  value       = module.argocd.namespace
}

output "argocd_chart_version" {
  description = "Versão do chart do ArgoCD instalado"
  value       = module.argocd.chart_version
}

output "argocd_admin_username" {
  description = "Usuário padrão de administração do ArgoCD"
  value       = "admin"
}

output "argocd_admin_password_command" {
  description = "Comando para obter a senha inicial do admin do ArgoCD via kubectl"
  value       = "kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d; echo"
}

output "argocd_port_forward_command" {
  description = "Comando para acessar o painel do ArgoCD localmente em https://localhost:8080"
  value       = "kubectl port-forward svc/argocd-server -n argocd 8080:443"
}

output "argocd_local_url" {
  description = "URL local do ArgoCD via port-forward"
  value       = "https://localhost:8080"
}

# ------------------------------------------------------------------------------
# 8. Ingress Controller (Ingress NGINX)
# ------------------------------------------------------------------------------
output "ingress_nginx_namespace" {
  description = "Namespace do Ingress NGINX"
  value       = module.ingress_nginx.namespace
}

output "ingress_nginx_chart_version" {
  description = "Versão do chart do Ingress NGINX instalado"
  value       = module.ingress_nginx.chart_version
}

output "ingress_url_command" {
  description = "Comando para obter a URL pública da API/Ingress gerada pelo Load Balancer da AWS"
  value       = "kubectl -n toggle-master get ingress toggle-ingress -o jsonpath='http://{.status.loadBalancer.ingress[0].hostname}/auth/health'; echo"
}

# ------------------------------------------------------------------------------
# 9. External Secrets Operator & SSM
# ------------------------------------------------------------------------------
output "external_secrets_role_arn" {
  description = "ARN da IAM Role associada ao External Secrets Operator via IRSA"
  value       = module.external_secrets.iam_role_arn
}

output "ssm_database_url_param" {
  description = "Nome do parametro SSM da database_url"
  value       = aws_ssm_parameter.auth_service_database_url.name
}

output "ssm_master_key_param" {
  description = "Nome do parametro SSM da master_key"
  value       = aws_ssm_parameter.auth_service_master_key.name
}

output "ssm_flag_database_url_param" {
  description = "Nome do parametro SSM da database_url do flag-service"
  value       = aws_ssm_parameter.flag_service_database_url.name
}

output "ssm_targeting_database_url_param" {
  description = "Nome do parametro SSM da database_url do targeting-service"
  value       = aws_ssm_parameter.targeting_service_database_url.name
}

output "ssm_evaluation_redis_url_param" {
  description = "Nome do parametro SSM da redis_url do evaluation-service"
  value       = aws_ssm_parameter.evaluation_service_redis_url.name
}

output "ssm_evaluation_sqs_url_param" {
  description = "Nome do parametro SSM da sqs_url do evaluation-service"
  value       = aws_ssm_parameter.evaluation_service_sqs_url.name
}

output "ssm_evaluation_api_key_param" {
  description = "Nome do parametro SSM da service_api_key do evaluation-service"
  value       = aws_ssm_parameter.evaluation_service_api_key.name
}