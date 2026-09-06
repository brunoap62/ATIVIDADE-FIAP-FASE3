output "repository_urls" {
  description = "URLs dos repositórios ECR criados"
  value       = { for repo in aws_ecr_repository.repos : repo.name => repo.repository_url }
}

output "repository_arns" {
  description = "ARNs dos repositórios ECR criados"
  value       = aws_ecr_repository.repos[*].arn
}
