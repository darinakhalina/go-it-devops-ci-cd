# Backend configuration for Terraform state
# Uncomment after first 'terraform apply' to migrate state to S3

# terraform {
#   backend "s3" {
#     bucket         = "dasha-terraform-state-final"
#     key            = "final/terraform.tfstate"
#     region         = "eu-west-1"
#     dynamodb_table = "terraform-locks-final"
#     encrypt        = true
#   }
# }