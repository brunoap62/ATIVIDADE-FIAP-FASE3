output "cluster_name" {
  description = "Nome do cluster EKS"
  value       = aws_eks_cluster.main.name
}

output "cluster_endpoint" {
  description = "Endpoint da API do cluster EKS"
  value       = aws_eks_cluster.main.endpoint
}

output "cluster_certificate_authority_data" {
  description = "Certificado CA do cluster EKS"
  value       = aws_eks_cluster.main.certificate_authority[0].data
}

output "cluster_security_group_id" {
  description = "ID do Security Group do Cluster EKS"
  value       = aws_security_group.eks_cluster.id
}

output "oidc_provider_arn" {
  description = "ARN do provedor OIDC para IRSA"
  value       = aws_iam_openid_connect_provider.eks.arn
}
