terraform {
  cloud {
    hostname = "app.terraform.io"
    organization = "hashicorp-v2"

    workspaces {
      name = "dsr-cli"
    }
  }
}

provider "tfe" {
  hostname = "app.terraform.io"
  organization = "hashicorp-v2"
}

data "null_data_source" "values" {
  inputs = {
    y = timestamp()
  }
}
