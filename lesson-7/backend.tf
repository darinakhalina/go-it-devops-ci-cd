# Backend configuration for Terraform state
# Uncomment after first 'terraform apply' to migrate state to S3

# terraform {
#   backend "s3" {
#     bucket         = "dasha-terraform-state-lesson7"
#     key            = "lesson-7/terraform.tfstate"
#     region         = "eu-west-1"
#     dynamodb_table = "terraform-locks-lesson7"
#     encrypt        = true
#   }
# }