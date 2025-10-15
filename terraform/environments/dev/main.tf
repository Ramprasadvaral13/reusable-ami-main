terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }

  backend "s3" {
    bucket         = "shreyas-terraform-state-bucket-123456"
    key            = "networking/vpc/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source = "git::https://github.com/Ramprasadvaral13/reusable-ami-module.git//networking?ref=main"

  vpc_cidr   = var.vpc_cidr
  route_cidr = var.route_cidr
  subnets    = var.subnets
}

module "compute" {
  source = "git::https://github.com/Ramprasadvaral13/reusable-ami-module.git//compute?ref=main"

  name_prefix      = "dev"
  vpc_id           = module.vpc.vpc_id
  subnet_ids       = module.vpc.private_subnet_ids
  instance_type    = var.instance_type
  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity
  volume_size = var.volume_size
}

