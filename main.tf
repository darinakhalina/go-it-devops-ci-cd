terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0.0"
    }
  }
}

# AWS Provider
provider "aws" {
  region = var.region
}

# S3 Backend Module (for Terraform state)
module "s3_backend" {
  source      = "./modules/s3-backend"
  bucket_name = "dasha-terraform-state-lesson-8-9"
  table_name  = "terraform-locks-lesson-8-9"
}

# VPC Module
module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr_block     = "10.0.0.0/16"
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets    = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  availability_zones = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  vpc_name           = "lesson-8-9-vpc"
}

# ECR Module
module "ecr" {
  source       = "./modules/ecr"
  ecr_name     = var.repository_name
  scan_on_push = true
}

# EKS Module
module "eks" {
  source        = "./modules/eks"
  cluster_name  = var.cluster_name
  subnet_ids    = module.vpc.public_subnets
  instance_type = var.instance_type
  desired_size  = 1
  max_size      = 2
  min_size      = 1
}