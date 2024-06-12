terraform {
  required_providers {
    tfe = {
      source = "hashicorp/tfe"
      version = "0.50.0"
    }
  }

  cloud {
    organization = "hashicorp"
    hostname = "tfcdev-781a2fe5.ngrok.io" # Optional; defaults to app.terraform.io

    workspaces {
      tags = ["child-workspaces"]
    }
  }
}

provider "tfe" {
  hostname = "tfcdev-781a2fe5.ngrok.io"
  organization = "hashicorp"
}

resource "tfe_workspace" "one" {
  name = "run-trigger-source"
  force_delete = true
}

resource "tfe_workspace" "two" {
  name = "run-trigger-target"
  force_delete = true
}

resource "tfe_run_trigger" "trigger" {
  workspace_id = tfe_workspace.two.id
  sourceable_id = tfe_workspace.one.id
}
