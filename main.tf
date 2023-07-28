provider "aws" {
}

locals {
  instance_types = [
    "t2.nano",
    "t2.micro",
    "t2.small",
    "t2.medium",
    "t2.large",
    "t2.xlarge",
    "t2.2xlarge",
    "t3.nano",
    "t3.micro",
    "t3.small",
    "t3.medium",
    "t3.large",
    "t3.xlarge",
    "t3.2xlarge",
    "t3a.nano",
    "t3a.micro",
    "t3a.small",
    "t3a.medium",
    "t3a.large",
    "t3a.xlarge",
    "t3a.2xlarge",
    "t4g.nano",
    "t4g.micro",
    "t4g.small",
    "t4g.medium",
    "t4g.large",
    "t4g.xlarge",
    "t4g.2xlarge"
  ]
}

resource "aws_rds_cluster" "example" {
  cluster_identifier = "example"
  engine             = "aurora-postgresql"
  engine_mode        = "provisioned"
  engine_version     = "14.6"
  database_name      = "test"
  master_username    = "test"
  master_password    = "must_be_eight_characters"

  serverlessv2_scaling_configuration {
    max_capacity = 1.0
    min_capacity = 0.5
  }
}

resource "aws_rds_cluster_instance" "example" {
  cluster_identifier = aws_rds_cluster.example.id
  instance_class     = "db.serverless"
  engine             = aws_rds_cluster.example.engine
  engine_version     = aws_rds_cluster.example.engine_version
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  count = 28

  ami           = data.aws_ami.ubuntu.id
  instance_type = local.instance_types[count.index % length(local.instance_types)]

  tags = {
    Name = "HelloWorld ${count.index}"
  }
}
