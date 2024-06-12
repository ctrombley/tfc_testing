terraform {
  required_providers {
    tfe = {
      source = "hashicorp/tfe"
      version = "0.50.0"
    }
  }

  cloud {
    organization = "hashicorp"
    hostname = "tfcdev-781a2fe5.ngrok.io" # Optional; defaults to app.terraform.io

    workspaces {
      tags = ["run-trigger-target"]
    }
  }
}

provider "null" {}

resource "null_resource" "example" {}
