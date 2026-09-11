# ==============================================================================
# IAM Policies e Roles para Integracao com EKS, SQS e DynamoDB (IRSA)
# ==============================================================================

# Permissao IAM para os nos do EKS enviarem mensagens para a fila SQS
resource "aws_iam_role_policy" "eks_node_sqs" {
  name = "${var.project_name}-node-sqs-policy"
  role = var.node_role_name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sqs:SendMessage",
          "sqs:GetQueueUrl",
          "sqs:GetQueueAttributes"
        ]
        Resource = var.sqs_queue_arn
      }
    ]
  })
}

# IAM Role (IRSA) para o evaluation-service enviar mensagens para o SQS
resource "aws_iam_role" "evaluation_sqs_irsa" {
  name = "${var.project_name}-evaluation-sqs-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = var.oidc_provider_arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "${replace(var.oidc_provider_url, "https://", "")}:sub" = "system:serviceaccount:toggle-master:evaluation-service-sa"
            "${replace(var.oidc_provider_url, "https://", "")}:aud" = "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "evaluation_sqs_policy" {
  name = "${var.project_name}-evaluation-sqs-policy"
  role = aws_iam_role.evaluation_sqs_irsa.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sqs:SendMessage",
          "sqs:GetQueueUrl",
          "sqs:GetQueueAttributes"
        ]
        Resource = var.sqs_queue_arn
      }
    ]
  })
}

# IAM Role (IRSA) para o analytics-service ler do SQS e gravar no DynamoDB
resource "aws_iam_role" "analytics_sqs_dynamodb_irsa" {
  name = "${var.project_name}-analytics-irsa-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = var.oidc_provider_arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "${replace(var.oidc_provider_url, "https://", "")}:sub" = "system:serviceaccount:toggle-master:analytics-service-sa"
            "${replace(var.oidc_provider_url, "https://", "")}:aud" = "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "analytics_sqs_dynamodb_policy" {
  name = "${var.project_name}-analytics-sqs-dynamodb-policy"
  role = aws_iam_role.analytics_sqs_dynamodb_irsa.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueUrl",
          "sqs:GetQueueAttributes"
        ]
        Resource = var.sqs_queue_arn
      },
      {
        Effect = "Allow"
        Action = [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:DescribeTable",
          "dynamodb:BatchWriteItem"
        ]
        Resource = var.dynamodb_table_arn
      }
    ]
  })
}
