terraform {
  required_providers {
    tfe = {
      version = "~> 0.35.0"
    }
  }
}

provider "tfe" {
  hostname = var.hostname
}

resource "tfe_workspace" "child" {
  count        = 3
  organization = var.organization
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
