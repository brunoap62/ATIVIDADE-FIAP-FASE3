resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = var.chart_version
  namespace        = var.namespace
  create_namespace = true
  timeout          = 600
  wait             = true

  set {
    name  = "server.service.type"
    value = var.server_service_type
  }

  set {
    name  = "configs.cm.timeout\\.reconciliation"
    value = var.timeout_reconciliation
  }
}


