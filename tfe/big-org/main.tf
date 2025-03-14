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

  tags = {
    1 = "project-tag-1"
    2 = "project-tag-2"
    3 = "project-tag-3"
    4 = "project-tag-4"
    5 = "project-tag-5"
    6 = "project-tag-6"
    7 = "project-tag-7"
    8 = "project-tag-8"
    9 = "project-tag-9"
    0 = "project-tag-0"
  }
}

resource "tfe_workspace" "big_org_workspace" {
  count = local.workspaces_per_project * local.project_count

  organization = tfe_organization.big_org.name
  name = "workspace-${count.index}"
  project_id = tfe_project.big_org_project[count.index % local.project_count].id

  tags = {
    1 = "workspace-tag-1"
    2 = "workspace-tag-2"
    3 = "workspace-tag-3"
    4 = "workspace-tag-4"
    5 = "workspace-tag-5"
    6 = "workspace-tag-6"
    7 = "workspace-tag-7"
    8 = "workspace-tag-8"
    9 = "workspace-tag-9"
    0 = "workspace-tag-0"
  }
}
