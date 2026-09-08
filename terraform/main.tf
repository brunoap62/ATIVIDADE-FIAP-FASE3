# ==============================================================================
# 1. Módulo de Rede (Networking - VPC, Subnets Públicas/Privadas, IGW e NAT GW)
# ==============================================================================
# Cria a topologia de rede isolada onde o cluster EKS, RDS e ElastiCache serão alocados.
module "network" {
  source = "./modules/network-vpc"

  project_name         = var.project_name
  cluster_name         = var.cluster_name
  vpc_cidr             = "10.0.0.0/16"
  availability_zones   = ["${var.aws_region}a", "${var.aws_region}b"]
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.10.0/24", "10.0.20.0/24"]
}

# ==============================================================================
# 2. Módulo do Cluster Kubernetes (AWS EKS & Managed Node Groups)
# ==============================================================================
# Orquestrador de contêineres provisionado dentro das subnets privadas da VPC.
# A dependência do módulo 'network' é resolvida automaticamente pelo Terraform.
module "eks" {
  source = "./modules/eks"

  project_name        = var.project_name
  cluster_name        = var.cluster_name
  cluster_version     = "1.31"
  vpc_id              = module.network.vpc_id
  subnet_ids          = module.network.private_subnet_ids
  node_instance_types = ["t3.medium"]
  desired_size        = 1
  min_size            = 1
  max_size            = 4
}

# ==============================================================================
# 3. Módulo de Banco de Dados Relacional (AWS RDS PostgreSQL)
# ==============================================================================
# Banco de dados relacional com acesso liberado exclusivamente para os nós do EKS.
# As dependências dos módulos 'network' e 'eks' são resolvidas automaticamente.
module "rds" {
  source = "./modules/rds"

  project_name          = var.project_name
  vpc_id                = module.network.vpc_id
  subnet_ids            = module.network.private_subnet_ids
  eks_security_group_id = module.eks.cluster_security_group_id
  db_instance_class     = "db.t3.micro"
  db_username           = var.db_username
  db_password           = var.db_password
}


# ==============================================================================
# 4. Módulo de Cache em Memória (AWS ElastiCache Redis) [COMENTADO]
# ==============================================================================
# Cache em memória e controle de sessão/flags com acesso seguro via SG do EKS.
# As dependências dos módulos 'network' e 'eks' são resolvidas automaticamente.
# module "redis" {
#   source = "./modules/redis"
# 
#   project_name          = var.project_name
#   vpc_id                = module.network.vpc_id
#   subnet_ids            = module.network.private_subnet_ids
#   eks_security_group_id = module.eks.cluster_security_group_id
#   node_type             = "cache.t3.micro"
#   engine_version        = "7.0"
# }

# ==============================================================================
# 5. Módulo de Banco de Dados NoSQL (AWS DynamoDB) [COMENTADO]
# ==============================================================================
# Tabela NoSQL gerenciada e serverless (sob demanda) para analytics de eventos.
# module "dynamodb" {
#   source = "./modules/dynamodb"
# 
#   table_name   = "ToggleMasterAnalytics"
#   billing_mode = "PAY_PER_REQUEST"
#   hash_key     = "event_id"
# }

# ==============================================================================
# 6. Módulo de Mensageria Assíncrona (AWS SQS) [COMENTADO]
# ==============================================================================
# Fila SQS para desacoplamento e comunicação assíncrona entre os microsserviços.
# module "sqs" {
#   source   = "./modules/sqs"
#   sqs_name = "jojo-bizzarre-adventure-sqs"
# }

# ==============================================================================
# 7. Módulo de Armazenamento de Objetos (AWS S3) [COMENTADO]
# ==============================================================================
# Bucket S3 configurado por workspace para armazenamento estático e artefatos de IaC.
# module "s3" {
#   source         = "./modules/s3"
#   s3_bucket_name = "jojo-bizzarre-adventure-iac"
#   s3_tags = {
#     Iac = true
#   }
# }

# ==============================================================================
# 8. Módulo de Registro de Contêineres (AWS ECR)
# ==============================================================================
# Repositórios privados de imagens Docker dos microsserviços com scan e política de ciclo de vida.
module "ecr" {
  source = "./modules/ecr"
  repository_names = [
    "jojo/auth-service-${terraform.workspace}",
    "jojo/flag-service-${terraform.workspace}",
    "jojo/targeting-service-${terraform.workspace}",
    "jojo/evaluation-service-${terraform.workspace}",
    "jojo/analytics-service-${terraform.workspace}"
  ]
}

# ==============================================================================
# 9. Módulo GitOps / CD (ArgoCD)
# ==============================================================================
# Instalação do ArgoCD via Helm Chart gerenciado diretamente pelo Terraform no cluster EKS.
module "argocd" {
  source = "./modules/argocd"

  namespace           = "argocd"
  server_service_type = "LoadBalancer"

  depends_on = [module.eks]
}

# ==============================================================================
# 10. Módulo Ingress Controller (Ingress NGINX + AWS NLB)
# ==============================================================================
# Instalação do Ingress NGINX via Helm Chart para gerenciar o Load Balancer e roteamento HTTP/HTTPS.
module "ingress_nginx" {
  source = "./modules/ingress-nginx"

  namespace     = "ingress-nginx"
  chart_version = "4.12.0"

  depends_on = [module.eks]
}