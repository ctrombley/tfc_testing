terraform {
  cloud {
    organization = "hashicorp"
    hostname = "tfcdev-781a2fe5.ngrok.io" # Optional; defaults to app.terraform.io

    workspaces {
      tags = ["big-org"]
    }
  }
}

locals {
  project_count = 100
  workspaces_per_project = 100
}

provider "tfe" {
    hostname = "tfcdev-781a2fe5.ngrok.io"
}

resource "tfe_organization" "big_org" {
  name = "big-org"
  email = "chris.trombley@hashicorp.com"
}

resource "tfe_project" "big_org_project" {
  count = local.project_count

  organization = tfe_organization.big_org.name
  name = "project-${count.index}"
}

resource "tfe_workspace" "big_org_workspace" {
  count = local.workspaces_per_project * local.project_count

  organization = tfe_organization.big_org.name
  name = "workspace-${count.index}"
  project_id = tfe_project.big_org_project[count.index % local.project_count].id
}
