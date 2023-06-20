terraform {
  required_providers {
    aws = {
      version = "~> 5.4.0"
    }

    hcp = {
      version = "~> 0.61.0"
    }
  }
}
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-west-1a"]
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.101.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true
}

module "web_server_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"

  name        = "web-server"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = module.vpc.private_subnets_cidr_blocks
}

module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name           = "deployer-one"
  create_private_key = true
}

data "hcp_packer_image" "learn-packer_image" {
  bucket_name     = "learn-packer"
  channel         = "latest"
  cloud_provider  = "aws"
  region          = "us-west-2"
}

resource "aws_instance" "hashiapp" {
  ami                         = data.hcp_packer_image.learn-packer_image.cloud_image_id
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  subnet_id                   = module.vpc.private_subnets[0]
  vpc_security_group_ids      = [module.web_server_sg.security_group_id]
  key_name                    = module.key_pair.key_pair_name

  lifecycle {
    postcondition {
      condition     = self.ami == data.hcp_packer_image.learn-packer_image.cloud_image_id
      error_message = "Must use the latest available AMI, ${data.hcp_packer_image.learn-packer-image.cloud_image_id}."
    }
  }
}
