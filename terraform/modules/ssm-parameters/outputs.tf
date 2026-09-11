output "auth_database_url_param" {
  description = "Nome do parametro SSM da database_url do auth-service"
  value       = aws_ssm_parameter.auth_service_database_url.name
}

output "auth_master_key_param" {
  description = "Nome do parametro SSM da master_key do auth-service"
  value       = aws_ssm_parameter.auth_service_master_key.name
}

output "flag_database_url_param" {
  description = "Nome do parametro SSM da database_url do flag-service"
  value       = aws_ssm_parameter.flag_service_database_url.name
}

output "targeting_database_url_param" {
  description = "Nome do parametro SSM da database_url do targeting-service"
  value       = aws_ssm_parameter.targeting_service_database_url.name
}

output "evaluation_redis_url_param" {
  description = "Nome do parametro SSM da redis_url do evaluation-service"
  value       = aws_ssm_parameter.evaluation_service_redis_url.name
}

output "evaluation_sqs_url_param" {
  description = "Nome do parametro SSM da sqs_url do evaluation-service"
  value       = aws_ssm_parameter.evaluation_service_sqs_url.name
}

output "evaluation_api_key_param" {
  description = "Nome do parametro SSM da service_api_key do evaluation-service"
  value       = aws_ssm_parameter.evaluation_service_api_key.name
}

output "analytics_dynamodb_table_param" {
  description = "Nome do parametro SSM da tabela DynamoDB do analytics-service"
  value       = aws_ssm_parameter.analytics_service_dynamodb_table.name
}

output "analytics_sqs_url_param" {
  description = "Nome do parametro SSM da sqs_url do analytics-service"
  value       = aws_ssm_parameter.analytics_service_sqs_url.name
}
