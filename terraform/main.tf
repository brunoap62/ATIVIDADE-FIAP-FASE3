# ==============================================================================
# 1. Módulo de Rede (Networking)
# ==============================================================================
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
# 2. Módulo do Cluster Kubernetes (EKS)
# ==============================================================================
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
# 3. Módulo de Bancos de Dados & Cache (RDS, ElastiCache, DynamoDB)
# ==============================================================================
module "redis" {
  source = "./modules/redis"

  project_name          = var.project_name
  vpc_id                = module.network.vpc_id
  subnet_ids            = module.network.private_subnet_ids
  eks_security_group_id = module.eks.cluster_security_group_id
  node_type             = "cache.t3.micro"
  engine_version        = "7.0"
}

# ==============================================================================
# 5. Módulo de Banco de Dados NoSQL (AWS DynamoDB)
# ==============================================================================
module "dynamodb" {
  source = "./modules/dynamodb"

  table_name   = "ToggleMasterAnalytics"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "event_id"
}
# ==============================================================================
# 3. Módulo de Bancos de Dados Relacionais (AWS RDS PostgreSQL)
# ==============================================================================
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
module "s3" {
  source         = "./modules/s3"
  s3_bucket_name = "jojo-bizzarre-adventure-iac"
  s3_tags = {
    Iac = true
  }
}



module "sqs" {
  source   = "./modules/sqs"
  sqs_name = "jojo-bizzarre-adventure-sqs"
}


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