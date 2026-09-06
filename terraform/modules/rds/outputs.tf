output "db_endpoint" {
  description = "Endpoint de conexão do banco RDS PostgreSQL"
  value       = aws_db_instance.main.endpoint
}

output "db_address" {
  description = "Endereço do host do banco RDS PostgreSQL"
  value       = aws_db_instance.main.address
}

output "db_port" {
  description = "Porta de conexão do banco RDS PostgreSQL"
  value       = aws_db_instance.main.port
}

output "db_name" {
  description = "Nome do banco de dados inicial"
  value       = aws_db_instance.main.db_name
}

output "db_subnet_group_name" {
  description = "Nome do subnet group do RDS"
  value       = aws_db_subnet_group.rds.name
}

output "db_security_group_id" {
  description = "ID do security group do RDS"
  value       = aws_security_group.rds.id
}
