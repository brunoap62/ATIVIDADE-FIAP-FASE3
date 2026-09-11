output "evaluation_sqs_role_arn" {
  description = "ARN da IAM Role do evaluation-service para IRSA"
  value       = aws_iam_role.evaluation_sqs_irsa.arn
}

output "analytics_sqs_dynamodb_role_arn" {
  description = "ARN da IAM Role do analytics-service para IRSA"
  value       = aws_iam_role.analytics_sqs_dynamodb_irsa.arn
}
