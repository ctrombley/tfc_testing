terraform {
  cloud {
    hostname = "app.staging.terraform.io"
    organization = "trombs-test-org"

    workspaces {
      name = "daikon"
    }
  }
}

provider "tfe" {
  hostname = "app.staging.terraform.io"
}

data "null_data_source" "values" {
  inputs = {
    y = timestamp()
  }
}
