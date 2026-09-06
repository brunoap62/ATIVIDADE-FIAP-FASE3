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

module "s3" {
  source         = "./modules/s3"
  s3_bucket_name = "jojo-bizzarre-adventure-iac"
  s3_tags = {
    Iac = true
  }
}

module "cloudfront" {
  source             = "./modules/cloudfront"
  origin_id          = module.s3.bucket_id
  bucket_domain_name = module.s3.bucket_domain_name
  cdn_price_class    = "PriceClass_200"
  cdn_tags = {
    Iac = true
  }

  depends_on = [
    module.s3
  ]
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