terraform {
  cloud {
    hostname = "tfcdev-781a2fe5.ngrok.io"
    organization = "hashicorp"

    workspaces {
      name = "cw2"
    }
  }
}

provider "tfe" {
  hostname = "tfcdev-781a2fe5.ngrok.io"
}

data "tfe_project" "this" {
  organization = "hashicorp"
  name = "Experiments"
}

resource "tfe_workspace" "child" {
  count        = 8
  organization = "hashicorp"
  name         = "child-${count.index}-${random_id.child_id.id}"
  project_id = data.tfe_project.this.id
}

resource "random_id" "child_id" {
  byte_length = 8
}

output "workspace_id" {
  value = tfe_workspace.child[*].id
}
