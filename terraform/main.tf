resource "aws_s3_bucket" "my_bucket" {
  bucket = "rocketseat-bucket-brsantos-iac"
  
  tags = {
    Name = "primeiro-bucket"
    Iac = true
  }
}