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

locals {
  subnets = [for s in data.aws_subnet.my_subnet : s.cidr_block]
}

data "aws_vpc" "my_vpc" {
  id = "vpc-0a0b86c69679fc450"
}

data "aws_subnets" "my_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.my_vpc.id]
  }
}

data "aws_subnet" "my_subnet" {
  for_each = toset(data.aws_subnets.my_subnets.ids)
  id       = each.value
}


module "web_server_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"

  name        = "web-server"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = data.aws_vpc.my_vpc.id

  ingress_cidr_blocks = local.subnets
}

data "hcp_packer_image" "learn-packer_image" {
  bucket_name     = "learn-packer"
  channel         = "latest"
  cloud_provider  = "aws"
  region          = "us-west-2"
}

resource "aws_instance" "learn-packer_image" {
  ami                         = data.hcp_packer_image.learn-packer_image.cloud_image_id
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  subnet_id                   = "subnet-0376a27ebed64a528"
  vpc_security_group_ids      = [module.web_server_sg.security_group_id]
  key_name                    = "test"

  lifecycle {
    postcondition {
      condition     = self.ami == data.hcp_packer_image.learn-packer_image.cloud_image_id
      error_message = "Must use the latest available AMI, ${data.hcp_packer_image.learn-packer_image.cloud_image_id}."
    }
  }
}

check "ami_version_check" {
  assert {
    condition = aws_instance.learn-packer_image.ami == data.hcp_packer_image.learn-packer_image.cloud_image_id
    error_message = "Must use the latest available AMI, ${data.hcp_packer_image.learn-packer_image.cloud_image_id}."
  }
}

