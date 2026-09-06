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
  source   = "./modules/ecr"
  repository_names = [
    "jojo/auth-service-${terraform.workspace}",
    "jojo/flag-service-${terraform.workspace}",
    "jojo/targeting-service-${terraform.workspace}",
    "jojo/evaluation-service-${terraform.workspace}",
    "jojo/analytics-service-${terraform.workspace}"
  ]

}