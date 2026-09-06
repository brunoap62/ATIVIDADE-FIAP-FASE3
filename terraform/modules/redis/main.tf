# ==============================================================================
# Subnet Group e Security Group para AWS ElastiCache (Redis)
# ==============================================================================
resource "aws_elasticache_subnet_group" "redis" {
  name       = "${var.project_name}-redis-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.project_name}-redis-subnet-group"
  }
}

resource "aws_security_group" "redis" {
  name        = "${var.project_name}-redis-sg"
  description = "Permite acesso Redis (porta 6379) a partir do cluster EKS"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    security_groups = [var.eks_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-redis-sg"
  }
}

# ==============================================================================
# Cluster ElastiCache (Redis)
# ==============================================================================
resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "${var.project_name}-redis"
  engine               = "redis"
  node_type            = var.node_type
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  engine_version       = var.engine_version
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.redis.name
  security_group_ids   = [aws_security_group.redis.id]

  tags = {
    Name = "${var.project_name}-redis"
  }
}
