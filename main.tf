terraform {
  required_providers {
    tfe = {
      version = "~> 0.51.0"
    }
  }
}

resource "tfe_registry_gpg_key" "ctrombley" {
  ascii_armor = file("public-key.pgp")
}
