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
# 3. Cache & Mensageria (ElastiCache Redis & SQS)
# ------------------------------------------------------------------------------
output "redis_endpoint" {
  description = "Endpoint do cluster ElastiCache Redis"
  value       = module.redis.redis_endpoint
}

output "redis_port" {
  description = "Porta de conexão do cluster Redis"
  value       = module.redis.redis_port
}

output "sqs_queue_url" {
  description = "URL da fila SQS criada"
  value       = module.sqs.queue_id
}

output "sqs_queue_arn" {
  description = "ARN da fila SQS criada"
  value       = module.sqs.queue_arn
}

# ------------------------------------------------------------------------------
# 4. Banco de Dados Relacional (RDS PostgreSQL - 100% Free Tier)
# ------------------------------------------------------------------------------
output "rds_endpoint" {
  description = "Endpoint completo de conexão do banco RDS PostgreSQL"
  value       = module.rds.db_endpoint
}

output "rds_address" {
  description = "Host do banco RDS PostgreSQL"
  value       = module.rds.db_address
}

output "rds_port" {
  description = "Porta do banco RDS PostgreSQL"
  value       = module.rds.db_port
}

output "rds_database_name" {
  description = "Nome do banco de dados inicial no RDS"
  value       = module.rds.db_name
}

# ------------------------------------------------------------------------------
# 5. Banco de Dados NoSQL (DynamoDB)
# ------------------------------------------------------------------------------
output "dynamodb_table_name" {
  description = "Nome da tabela DynamoDB para analytics"
  value       = module.dynamodb.table_name
}

output "dynamodb_table_arn" {
  description = "ARN da tabela DynamoDB para analytics"
  value       = module.dynamodb.table_arn
}

# ------------------------------------------------------------------------------
# 6. Storage & Registro de Containers (S3 & ECR)
# ------------------------------------------------------------------------------
output "s3_bucket_name" {
  description = "Nome do bucket S3"
  value       = module.s3.bucket_domain_name
}

output "s3_bucket_id" {
  description = "ID do bucket S3"
  value       = module.s3.bucket_id
}

output "ecr_repository_urls" {
  description = "URLs dos repositórios ECR criados"
  value       = module.ecr.repository_urls
}

output "ecr_repository_arns" {
  description = "ARNs dos repositórios ECR criados"
  value       = module.ecr.repository_arns
}