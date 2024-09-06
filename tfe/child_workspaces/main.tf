terraform {
  cloud {
    hostname = "app.terraform.io"
    organization = "hashicorp-v2"

    workspaces {
      name = "cw2"
    }
  }
}

provider "tfe" {
  hostname = "app.terraform.io"
}

resource "tfe_workspace" "child" {
  count        = 6
  organization = "hashicorp-v2"
  name         = "child-${count.index}-${random_id.child_id.id}"
  project_id      = "prj-VgZnZTKhJrKxfXwr"
}

resource "random_id" "child_id" {
  byte_length = 8
}
