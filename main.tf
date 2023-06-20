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

data "hcp_packer_image" "learn-packer_image" {
  bucket_name     = "learn-packer"
  channel         = "latest"
  cloud_provider  = "aws"
  region          = "us-west-2"
}

resource "aws_instance" "hashiapp" {
  ami                         = data.hcp_packer_image.learn-packer_image.cloud_image_id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.hashiapp.id
  vpc_security_group_ids      = [aws_security_group.hashiapp.id]
  key_name                    = aws_key_pair.generated_key.key_name

  lifecycle {
    postcondition {
      condition     = self.ami == data.hcp_packer_image.learn-packer_image.cloud_image_id
      error_message = "Must use the latest available AMI, ${data.hcp_packer_image.hashiapp_image.cloud_image_id}."
    }
  }
}
