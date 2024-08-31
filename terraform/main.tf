terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.65.0"
    }
  }

  required_version = ">= 1.9.0"
}


module "ec2" {
  source = "./ec2"
  tags   = var.tags
}

module "ecr" {
  source = "./ecr"
  tags   = var.tags
}
