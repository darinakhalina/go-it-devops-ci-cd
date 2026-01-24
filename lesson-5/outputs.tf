# Виведення інформації про S3 та DynamoDB
output "s3_bucket_name" {
  description = "Назва S3-бакета для стейтів"
  value       = module.s3_backend.s3_bucket_name
}

output "dynamodb_table_name" {
  description = "Назва таблиці DynamoDB"
  value       = module.s3_backend.dynamodb_table_name
}

# Виведення інформації про VPC
output "vpc_id" {
  description = "ID VPC"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "ID публічних підмереж"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "ID приватних підмереж"
  value       = module.vpc.private_subnets
}

# Виведення інформації про ECR
output "ecr_repository_url" {
  description = "URL ECR репозиторію"
  value       = module.ecr.ecr_repository_url
}