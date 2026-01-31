variable "region" {
  description = "AWS region for deployment"
  type        = string
  default     = "eu-west-1"
}

variable "github_username" {
  description = "GitHub username"
  type        = string
  sensitive   = true
  default     = ""  # Will be set in terraform.tfvars for Jenkins/ArgoCD
}

variable "github_token" {
  description = "GitHub Personal Access Token"
  type        = string
  sensitive   = true
  default     = ""  # Will be set in terraform.tfvars for Jenkins/ArgoCD
}

variable "github_repo_url" {
  description = "GitHub repository URL"
  type        = string
  default     = ""  # Will be set in terraform.tfvars for Jenkins/ArgoCD
}

variable "instance_type" {
  description = "EC2 instance type for the worker nodes"
  type        = string
  default     = "t3.small"
}

variable "repository_name" {
  description = "Name of the ECR repository"
  type        = string
  default     = "django-app"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "lesson-db-eks"
}

variable "db_password" {
  description = "Password for RDS database"
  type        = string
  sensitive   = true
  default     = ""
}