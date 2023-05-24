terraform {
  required_version = "~> 1.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

locals {
  default_tags = {
    hc-config-as-code = "terraform"
    hc-repo           = "github.com/hashicorp/geoblock-page"
    hc-owner-dl       = "team-cloudsec@hashicorp.com"
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = local.default_tags
  }
}
