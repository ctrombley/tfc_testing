terraform {
  required_providers {
    tfe = {
      version = "~> 0.49.2"
    }
  }
}

resource "tfe_workspace" "child" {
  count        = 3
  organization = var.organization
  name         = "child-${count.index}-${random_id.child_id.id}"
}

resource "random_id" "child_id" {
  byte_length = 9
}

resource "tfe_variable" "test-var" {
  key = "test_var"
  value = var.random_var
  category = "env"
  workspace_id = tfe_workspace.child[0].id
  description = "This allows the build agent to call back to TFC when executing plans and applies"
}

module "test_module" {
  source  = "hashicorp/module/random"
  version = "1.0.0"
}

check "health_check" {
  data "http" "terraform_io" {
    url = "https://www.terraform.io"
  }
  assert {
    condition = data.http.terraform_io.status_code == 200
    error_message = "${data.http.terraform_io.url} returned an unhealthy status code"
  }
}

