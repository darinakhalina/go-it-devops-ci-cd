# УВАГА: Розкоментуйте цей блок ПІСЛЯ першого terraform apply,
# коли S3-бакет та DynamoDB вже створені!

terraform {
  backend "s3" {
    bucket         = "dasha-terraform-state-lesson5"
    key            = "lesson-5/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
