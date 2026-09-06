output "cdn_domain_name" {
    value = data.aws_cloudfront_distribution.cloudfront.domain_name
    sensitive = false
    description = "The domain name corresponding to the distribution, e.g., d111111abcdef8.cloudfront.net"
}

output "cdn_id" {
    value = data.aws_cloudfront_distribution.cloudfront.id
    sensitive = false
    description = "The distribution ID that uniquely identifies the distribution."
}