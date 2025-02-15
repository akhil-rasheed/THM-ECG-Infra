terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.65.0"
    }
  }

  backend "s3" {
    bucket  = "thm-ecg-state-files"
    key     = "terraform.tfstate"
    region  = "eu-central-1"
    encrypt = true
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
