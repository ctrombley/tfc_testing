terraform {
  cloud {
    hostname = "app.terraform.io"
    organization = "trombs-test-org"

    workspaces {
      name = "plan-prune"
    }
  }
}

provider "tfe" {
  hostname = "app.terraform.io"
}

data "null_data_source" "values" {
  inputs = {
    y = timestamp()
  }
}
