output "redis_endpoint" {
  description = "Endpoint do cluster ElastiCache Redis"
  value       = aws_elasticache_cluster.redis.cache_nodes[0].address
}

output "redis_port" {
  description = "Porta do cluster ElastiCache Redis"
  value       = aws_elasticache_cluster.redis.port
}

output "redis_subnet_group_name" {
  description = "Nome do subnet group do ElastiCache"
  value       = aws_elasticache_subnet_group.redis.name
}

output "redis_security_group_id" {
  description = "ID do security group do Redis"
  value       = aws_security_group.redis.id
}
