terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.0.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
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
  bucket_name = "dasha-terraform-state-lesson-db"
  table_name  = "terraform-locks-lesson-db"
}

# VPC Module
module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr_block     = "10.0.0.0/16"
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets    = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  availability_zones = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  vpc_name           = "lesson-db-vpc"
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
  desired_size  = 2
  max_size      = 3
  min_size      = 1
}

# Data sources for EKS authentication
data "aws_eks_cluster" "eks" {
  name       = module.eks.cluster_name
  depends_on = [module.eks]
}

data "aws_eks_cluster_auth" "eks" {
  name       = module.eks.cluster_name
  depends_on = [module.eks]
}

# Kubernetes Provider
provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks.token
}

# Helm Provider
provider "helm" {
  kubernetes = {
    host                   = data.aws_eks_cluster.eks.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.eks.token
  }
}

# Jenkins Module
module "jenkins" {
  source            = "./modules/jenkins"
  cluster_name      = module.eks.cluster_name
  oidc_provider_arn = module.eks.oidc_provider_arn
  oidc_provider_url = module.eks.oidc_provider_url
  github_username   = var.github_username
  github_token      = var.github_token
  github_repo_url   = var.github_repo_url

  depends_on = [module.eks]
}

# Argo CD Module
module "argo_cd" {
  source          = "./modules/argo_cd"
  namespace       = "argocd"
  chart_version   = "5.46.4"
  github_username = var.github_username
  github_token    = var.github_token
  github_repo_url = var.github_repo_url

  depends_on = [module.eks]
}

# RDS Module
module "rds" {
  source = "./modules/rds"

  name                          = "myapp-db"
  use_aurora                    = true
  aurora_instance_count         = 2

  # --- Aurora-only ---
  engine_cluster                = "aurora-postgresql"
  engine_version_cluster        = "15.3"
  parameter_group_family_aurora = "aurora-postgresql15"

  # --- RDS-only ---
  engine                        = "postgres"
  engine_version                = "17.2"
  parameter_group_family_rds    = "postgres17"

  # Common
  instance_class                = "db.t3.medium"
  allocated_storage             = 20
  db_name                       = "myapp"
  username                      = "postgres"
  password                      = var.db_password
  subnet_private_ids            = module.vpc.private_subnets
  subnet_public_ids             = module.vpc.public_subnets
  publicly_accessible           = true
  vpc_id                        = module.vpc.vpc_id
  multi_az                      = false
  backup_retention_period       = 7
  parameters = {
    "max_connections" = "200"
  }

  tags = {
    Environment = "dev"
    Project     = "myapp"
  }
}