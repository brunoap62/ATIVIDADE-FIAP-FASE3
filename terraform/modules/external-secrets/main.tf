data "aws_caller_identity" "current" {}

locals {
  # Remove o prefixo https:// da URL do OIDC caso esteja presente
  oidc_issuer = replace(var.oidc_provider_url, "https://", "")
}

# ==============================================================================
# 1. IAM Policy para leitura segura no AWS SSM Parameter Store
# ==============================================================================
resource "aws_iam_policy" "external_secrets_ssm" {
  name        = "${var.project_name}-eso-ssm-policy"
  description = "Permite ao External Secrets Operator ler parametros criptografados no SSM"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ssm:GetParameter",
          "ssm:GetParameters",
          "ssm:GetParametersByPath",
          "ssm:DescribeParameters"
        ]
        Resource = "arn:aws:ssm:${var.aws_region}:${data.aws_caller_identity.current.account_id}:parameter/*"
      },
      {
        Effect = "Allow"
        Action = [
          "kms:Decrypt"
        ]
        Resource = "*"
      }
    ]
  })

  tags = var.tags
}

# ==============================================================================
# 2. IAM Role associada via OIDC (IRSA) para a ServiceAccount do ESO
# ==============================================================================
resource "aws_iam_role" "external_secrets" {
  name = "${var.project_name}-external-secrets-role"

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
            "${local.oidc_issuer}:sub" = "system:serviceaccount:${var.namespace}:${var.service_account_name}"
            "${local.oidc_issuer}:aud" = "sts.amazonaws.com"
          }
        }
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "external_secrets_ssm" {
  role       = aws_iam_role.external_secrets.name
  policy_arn = aws_iam_policy.external_secrets_ssm.arn
}

# ==============================================================================
# 3. Instalação do Helm Chart do External Secrets Operator (ESO)
# ==============================================================================
resource "helm_release" "external_secrets" {
  name             = "external-secrets"
  repository       = "https://charts.external-secrets.io"
  chart            = "external-secrets"
  version          = var.chart_version
  namespace        = var.namespace
  create_namespace = true
  timeout          = 600
  wait             = true

  set {
    name  = "installCRDs"
    value = "true"
  }

  set {
    name  = "serviceAccount.create"
    value = "true"
  }

  set {
    name  = "serviceAccount.name"
    value = var.service_account_name
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.external_secrets.arn
  }

  depends_on = [
    aws_iam_role_policy_attachment.external_secrets_ssm
  ]
}
