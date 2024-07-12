terraform {
  cloud {
    organization = "trombs-test-org"

    workspaces {
      tags = ["apple"]
    }
  }
}

provider "tfe" {
}

resource "tfe_workspace" "child" {
  count        = 6
  organization = "trombs-test-org"
  name         = "child-${count.index}-${random_id.child_id.id}"
}

resource "random_id" "child_id" {
  byte_length = 8
}

resource "tfe_variable" "test-var" {
  key = "test_var"
  value = random_id.child_id.id
  category = "env"
  workspace_id = tfe_workspace.child[0].id
  description = "This allows the build agent to call back to TFC when executing plans and applies"
}
