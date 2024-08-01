resource "tfe_variable_set" "varset" {
  name          = var.varset_name
  organization  = var.organization_name
}
