# ==============================================================================
# Kubernetes Service Accounts com Anotações IRSA Dinâmicas
# ==============================================================================
# Gerencia os Service Accounts no cluster EKS associando automaticamente o ARN
# dinâmico das IAM Roles criadas pelo Terraform (evita hardcode manual no GitOps).

# Service Account para o evaluation-service (permissão SQS:SendMessage)
resource "kubernetes_service_account" "evaluation_sa" {
  metadata {
    name      = "evaluation-service-sa"
    namespace = var.namespace
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.evaluation_sqs_irsa.arn
    }
    labels = {
      "app.kubernetes.io/name"       = "evaluation-service"
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }
}

# Service Account para o analytics-service (permissão SQS:ReceiveMessage + DynamoDB:PutItem)
resource "kubernetes_service_account" "analytics_sa" {
  metadata {
    name      = "analytics-service-sa"
    namespace = var.namespace
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.analytics_sqs_dynamodb_irsa.arn
    }
    labels = {
      "app.kubernetes.io/name"       = "analytics-service"
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }
}
