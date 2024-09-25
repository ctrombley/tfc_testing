terraform {
  cloud {
    organization = "trombs-test-org"
    hostname = "tfcdev-781a2fe5.ngrok.io" # Optional; defaults to app.terraform.io

    workspaces {
      tags = ["asdf"]
    }
  }
}

provider "tfe" {
  hostname = "tfcdev-781a2fe5.ngrok.io"
}

resource "null_resource" "test" { }


locals {
  foo = "bar"
}

deployment "staging" {
  inputs = {
    foo = local.foo
  }
}

publish_output "staging_id" {
  value = deployment.staging.id
}

deployment "production" {
  # Note that both tokens are referenced in this deployment
  inputs = {
    foo = local.foo
    staging_id = upstream_input.staging.id
  }
}

upstream_input "staging" {
  type = "stack"
  source = "host-name/org-name/project-name/staging"
}
