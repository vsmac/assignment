terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "bucket_name"
    region         = "us-east-1"
    key            = "eks-cluster/terraform.tfstate"
    dynamodb_table = "terraform_lock"
  }
}

provider "aws" {
  region = var.region
}

# Get core infra data
data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["${var.environment}-tf"]
  }
}

data "aws_subnet_ids" "stateful_worker_subnet_ids" {
  vpc_id = data.aws_vpc.vpc.id

  filter {
    name   = "tag:Name"
    values = ["${var.environment} subnet (private)", "${var.environment} subnet (public)"]
  }
}



module "eks" {
  source = "../modules/eks"

  name        = var.name
  region      = var.region
  environment = var.environment

  # stateful node group
  stateful_worker_subnet_ids    = data.aws_subnet_ids.stateful_worker_subnet_ids.ids
  stateful_worker_instance_type = "t2.medium"
  stateful_worker_desired_size  = 2
  stateful_worker_min_size      = 2
  stateful_worker_max_size      = 3

 
}
