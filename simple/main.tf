terraform {
  cloud {
    organization = "hashicorp"
    hostname = "tfcdev-781a2fe5.ngrok.io" # Optional; defaults to app.terraform.io

    workspaces {
      tags = ["provisioned-runs-chilm"]
    }
  }
}

provider "tfe" {
  hostname = "tfcdev-781a2fe5.ngrok.io"
}

resource "null_resource" "test" { }

