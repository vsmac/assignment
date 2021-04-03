terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "bucket_name"
    region         = "us-east-1"
    key            = "ecr-repository/terraform.tfstate"
    dynamodb_table = "terraform_lock"
  }
}

provider "aws" {
  region = var.region
}

module "ecr-repository" {
  source = "../modules/ecr-repository"

  name        = var.name
  region      = var.region
  environment = var.environment
}
