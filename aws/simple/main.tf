terraform {
  cloud {
    organization = "hashicorp"
    hostname = "tfcdev-781a2fe5.ngrok.io" # Optional; defaults to app.terraform.io

    workspaces {
      tags = ["aws-simple"]
    }
  }
}

provider "tfe" {
    hostname = "tfcdev-781a2fe5.ngrok.io"
}

resource "tfe_workspace" "child" {
  count        = 3
  organization = "hashicorp"
  name         = "child-${count.index}-${random_id.child_id.id}"
}

resource "random_id" "child_id" {
  byte_length = 8
}

resource "tfe_variable" "test-var" {
  key = "test_var"
  value = var.random_var
  category = "env"
  workspace_id = tfe_workspace.child[0].id
  description = "This allows the build agent to call back to TFC when executing plans and applies"
}

