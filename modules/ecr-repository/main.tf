provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {}
  required_version = ">= 0.14.4"
}

resource "aws_ecr_repository" "ecr_repo" {
  name                 = var.name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = var.name
    Environment = var.environment
    provisioner = "terraform"
  }
}
