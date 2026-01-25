variable "ecr_name" {
  description = "Ім'я ECR репозиторію"
  type        = string
}

variable "scan_on_push" {
  description = "Чи сканувати образи при push"
  type        = bool
  default     = true
}