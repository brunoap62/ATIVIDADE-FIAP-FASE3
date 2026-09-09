# ==============================================================================
# Subnet Group e Security Group para RDS PostgreSQL
# ==============================================================================
resource "aws_db_subnet_group" "rds" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.project_name}-db-subnet-group"
  }
}

resource "aws_security_group" "rds" {
  name        = "${var.project_name}-rds-sg"
  description = "Permite acesso PostgreSQL (porta 5432) a partir do cluster EKS"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    cidr_blocks     = ["10.0.0.0/16"]
    security_groups = [var.eks_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-rds-sg"
  }
}

# ==============================================================================
# 1 Instância AWS RDS PostgreSQL (FinOps Mínimo Absoluto & Zero Backups/Snapshots)
# ==============================================================================
resource "aws_db_instance" "main" {
  identifier     = "${var.project_name}-db"
  engine         = "postgres"
  engine_version = "15"
  instance_class = var.db_instance_class

  # Armazenamento mínimo no Free Tier (20GB gp2 sem autoscaling)
  allocated_storage     = 20
  max_allocated_storage = 0
  storage_type          = "gp2"

  db_name                = "auth_db"
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.rds.name
  vpc_security_group_ids = [aws_security_group.rds.id]

  # Configurações para deleção imediata e zero retenção/custos de backup
  skip_final_snapshot      = true
  backup_retention_period  = 0
  deletion_protection      = false
  delete_automated_backups = true

  # Desativação de monitoramento avançado e métricas pagas
  performance_insights_enabled = false
  monitoring_interval          = 0

  # Rede e alta disponibilidade desativada (Single-AZ)
  publicly_accessible = false
  multi_az            = false

  tags = {
    Name = "${var.project_name}-db"
  }
}
