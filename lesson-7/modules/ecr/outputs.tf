output "ecr_repository_url" {
  description = "URL ECR репозиторію"
  value       = aws_ecr_repository.main.repository_url
}

output "ecr_repository_arn" {
  description = "ARN ECR репозиторію"
  value       = aws_ecr_repository.main.arn
}

output "ecr_repository_name" {
  description = "Ім'я ECR репозиторію"
  value       = aws_ecr_repository.main.name
}