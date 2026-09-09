output "iam_role_arn" {
  description = "ARN da IAM Role criada para o External Secrets Operator (IRSA)"
  value       = aws_iam_role.external_secrets.arn
}

output "iam_role_name" {
  description = "Nome da IAM Role criada para o External Secrets Operator"
  value       = aws_iam_role.external_secrets.name
}

output "iam_policy_arn" {
  description = "ARN da IAM Policy para leitura de segredos no SSM"
  value       = aws_iam_policy.external_secrets_ssm.arn
}

output "namespace" {
  description = "Namespace onde o External Secrets Operator foi instalado"
  value       = helm_release.external_secrets.namespace
}

output "service_account_name" {
  description = "Nome da ServiceAccount configurada para o External Secrets Operator"
  value       = var.service_account_name
}
