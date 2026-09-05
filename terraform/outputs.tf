output "bucket_domain_name" {
  value = data.aws_s3_bucket.bucket.bucket_domain_name
  description = "Nome de dominio do bucket S3."
}

output "bucket_region" {
  value = data.aws_s3_bucket.bucket.region
  description = "Região do bucket S3."
}