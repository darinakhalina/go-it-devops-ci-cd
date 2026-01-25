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