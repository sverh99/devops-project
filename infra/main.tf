terraform {
  // installing plugin
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}


provider "aws" {
  region     = var.aws_region
  access_key = "AKIAVRLPV52TICZB6JS2"
  secret_key = "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"
}


module "vpc" {
  source = "./modules/vpc"

  vpc_cidr_block           = var.vpc_cidr_block
  public_subnet_cidr_block = var.public_subnet_cidr_block
}

module "security_group" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
  my_ip  = var.my_ip
}

module "ec2_instance" {
  source         = "./modules/compute"
  security_group = module.security_group.sg_id
  public_subnet  = module.vpc.public_subnet_id
}
