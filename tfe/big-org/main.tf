terraform {
  cloud {
    organization = "trombs-test-local"
    hostname = "tfcdev-781a2fe5.ngrok.io" # Optional; defaults to app.terraform.io

    workspaces {
      tags = ["var-halla"]
    }
  }
}

provider "tfe" {
    hostname = "tfcdev-781a2fe5.ngrok.io"
}

resource "tfe_workspace" "jan24-var-halla" {
    organization = "trombs-test-local"
    name = "jan24-var-halla"
}

resource "tfe_variable" "var-hella" {
    count = 700
    workspace_id = tfe_workspace.jan24-var-halla.id
    category = "terraform"
    key = "problebm-${count.index}"
    sensitive = ((count.index % 5) == 0)
}
