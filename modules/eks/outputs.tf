output "cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = aws_eks_cluster.eks.endpoint
}

output "cluster_name" {
  description = "EKS cluster name"
  value       = aws_eks_cluster.eks.name
}

output "cluster_certificate_authority" {
  description = "EKS cluster certificate authority data"
  value       = aws_eks_cluster.eks.certificate_authority[0].data
}

output "node_role_arn" {
  description = "IAM role ARN for EKS worker nodes"
  value       = aws_iam_role.nodes.arn
}

output "oidc_provider_arn" {
  description = "OIDC provider ARN for IRSA"
  value       = aws_iam_openid_connect_provider.oidc.arn
}

output "oidc_provider_url" {
  description = "OIDC provider URL for IRSA"
  value       = aws_iam_openid_connect_provider.oidc.url
}