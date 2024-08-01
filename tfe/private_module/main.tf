terraform {
  cloud {
    organization = "tfc-agent-testing"
    hostname = "tfcdev-781a2fe5.ngrok.io" # Optional; defaults to app.terraform.io

    workspaces {
      tags = ["tfc-agent-testing"]
    }
  }
}

module "simple" {
  source  = "tfcdev-781a2fe5.ngrok.io/tfc-agent-testing/simple/test"
  version = "1.0.3"
}
