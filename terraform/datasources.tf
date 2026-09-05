data "aws_s3_bucket" "bucket" {
    bucket = "${var.org_name}-bucket-brsantos-iac-${terraform.workspace}"
}