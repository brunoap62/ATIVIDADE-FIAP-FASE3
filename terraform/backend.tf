
terraform {
  backend "s3" {
    bucket       = "toggle-master-terraform-state-052717076243-us-east-2-an"
    key          = "infra/toggle-master/terraform.tfstate"
    region       = "us-east-2"
    use_lockfile = true
    encrypt      = true
  }
}