provider "aws" {
  region = "eu-central-1"
}

resource "aws_ecr_repository" "application-backend" {
  name                 = "application-backend"
  image_tag_mutability = "MUTABLE"
  tags                 = var.tags

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "application-frontend" {
  name                 = "application-frontend"
  image_tag_mutability = "MUTABLE"
  tags                 = var.tags

  image_scanning_configuration {
    scan_on_push = true
  }
}
