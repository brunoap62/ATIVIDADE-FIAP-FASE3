resource "aws_s3_bucket" "my_bucket" {
  bucket = "${var.org_name}-bucket-brsantos-iac-${terraform.workspace}"
  
  tags = {
    Name    = "primeiro-bucket"
    Iac     = true
    context = "${terraform.workspace}"
  }
}