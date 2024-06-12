terraform {
  cloud {
    organization = "hashicorp"
    hostname = "tfcdev-781a2fe5.ngrok.io" # Optional; defaults to app.terraform.io

    workspaces {
      tags = ["long-resource-names"]
    }
  }
}

provider "tfe" {
    hostname = "tfcdev-781a2fe5.ngrok.io"
}

resource "tfe_workspace" "workspace-with-the-very-longest-name-we-could-conceivably-come-up-with-1" {
  organization = "hashicorp"
  name         = "test-workspace"
}

moved {
  from = tfe_workspace.workspace-with-the-very-longest-name-we-could-conceivably-come-up-with
  to = tfe_workspace.workspace-with-the-very-longest-name-we-could-conceivably-come-up-with-1
}
