# AWS Provider
provider "aws" {
  region = "eu-west-1" # Ireland
}

# S3 Backend Module
module "s3_backend" {
  source      = "./modules/s3-backend"
  bucket_name = "dasha-terraform-state-lesson7"
  table_name  = "terraform-locks-lesson7"
}

# VPC Module
module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr_block     = "10.0.0.0/16"
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets    = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  availability_zones = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  vpc_name           = "lesson-7-vpc"
}

# ECR Module
module "ecr" {
  source       = "./modules/ecr"
  ecr_name     = "django-app"
  scan_on_push = true
}

# EKS Module
module "eks" {
  source        = "./modules/eks"
  cluster_name  = "lesson-7-eks"
  subnet_ids    = module.vpc.public_subnets
  instance_type = "t3.small"
  desired_size  = 2
  max_size      = 3
  min_size      = 1
}