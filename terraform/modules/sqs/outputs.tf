output "queue_id" {
  description = "URL da fila SQS criada"
  value       = aws_sqs_queue.terraform_queue.id
}

output "queue_arn" {
  description = "ARN da fila SQS criada"
  value       = aws_sqs_queue.terraform_queue.arn
}
