#-------------Backend-----------------
output "s3_bucket_name" {
  description = "S3 bucket for Terraform state"
  value       = module.s3_backend.s3_bucket_name
}

output "dynamodb_table_name" {
  description = "DynamoDB table for state locking"
  value       = module.s3_backend.dynamodb_table_name
}

#-------------VPC-----------------
output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "Public subnet IDs"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "Private subnet IDs"
  value       = module.vpc.private_subnets
}

#-------------ECR-----------------
output "ecr_repository_url" {
  description = "ECR repository URL"
  value       = module.ecr.ecr_repository_url
}

#-------------EKS-----------------
output "eks_cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "eks_node_role_arn" {
  description = "EKS node IAM role ARN"
  value       = module.eks.node_role_arn
}

output "oidc_provider_arn" {
  description = "OIDC provider ARN"
  value       = module.eks.oidc_provider_arn
}

#-------------Jenkins-----------------
output "jenkins_release" {
  description = "Jenkins Helm release name"
  value       = module.jenkins.jenkins_release_name
}

output "jenkins_namespace" {
  description = "Jenkins namespace"
  value       = module.jenkins.jenkins_namespace
}

#-------------ArgoCD-----------------
output "argocd_namespace" {
  description = "ArgoCD namespace"
  value       = module.argo_cd.namespace
}

output "argocd_server_service" {
  description = "ArgoCD server service"
  value       = module.argo_cd.argo_cd_server_service
}

output "argocd_admin_password" {
  description = "Command to get ArgoCD admin password"
  value       = module.argo_cd.admin_password
}

#-------------RDS-----------------
output "rds_endpoint" {
  description = "RDS database endpoint"
  value       = module.rds.rds_endpoint
}

output "rds_address" {
  description = "RDS database address"
  value       = module.rds.rds_address
}

output "rds_port" {
  description = "RDS database port"
  value       = module.rds.rds_port
}

output "aurora_cluster_endpoint" {
  description = "Aurora cluster endpoint (writer)"
  value       = module.rds.aurora_cluster_endpoint
}

output "aurora_reader_endpoint" {
  description = "Aurora cluster endpoint (reader)"
  value       = module.rds.aurora_reader_endpoint
}

output "db_subnet_group_name" {
  description = "DB Subnet Group name"
  value       = module.rds.db_subnet_group_name
}

output "db_security_group_id" {
  description = "Security Group ID for database"
  value       = module.rds.security_group_id
}