resource "aws_ecr_repository" "repos" {
  count                = length(var.repository_names)
  name                 = var.repository_names[count.index]
  image_tag_mutability = var.image_tag_mutability
  force_delete         = true

  # DevSecOps: Habilita escaneamento de vulnerabilidades no push
  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = var.repository_names[count.index]
    Iac  = true
  }
}



# ==============================================================================
# Política de Ciclo de Vida (FinOps: reter últimas 10 imagens)
# ==============================================================================
resource "aws_ecr_lifecycle_policy" "policy" {
  count      = length(aws_ecr_repository.repos)
  repository = aws_ecr_repository.repos[count.index].name

  policy = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "Reter apenas as ultimas 10 imagens para controle de custos de storage"
      selection = {
        tagStatus   = "any"
        countType   = "sinceImagePushed"
        countUnit   = "days"
        countNumber = 30
      }
      action = {
        type = "expire"
      }
    }]
  })
}
