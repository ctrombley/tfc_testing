terraform {
  cloud {
    hostname = "tfc_testing"
    organization = "hashicorp"

    workspaces {
      name = "cw2"
    }
  }
}

provider "tfe" {
  hostname = "app.terraform.io"
}

resource "tfe_project" "this" {
  organization = "hashicorp"
  name = "test"
}

resource "tfe_workspace" "child" {
  count        = 6
  organization = "hashicorp"
  name         = "child-${count.index}-${random_id.child_id.id}"
  project_id = tfe_project.this.id
}

resource "random_id" "child_id" {
  byte_length = 8
}
