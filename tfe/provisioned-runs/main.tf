provider "tfe" {
  hostname = "tfcdev-781a2fe5.ngrok.io"
}

resource "tfe_workspace" "childs" {
  count        = 3
  organization = "hashicorp"
  name         = "childs-${count.index}"
}

# resource "tfe_workspace_run" "runs" {
#   count = 3
#   workspace_id = tfe_workspace.child[count.index].id
#
#   apply {
#     manual_confirm    = false
#     wait_for_run      = true
#     retry_attempts    = 5
#     retry_backoff_min = 5
#   }
#
#   destroy {
#     manual_confirm    = false
#     wait_for_run      = true
#     retry_attempts    = 3
#     retry_backoff_min = 10
#   }
# }

resource "tfe_variable" "variables" {
  key             = "test2241928374"
  value   = file("settings.hcl")
  category        = "terraform"
  description     = "variablesdfs"
  hcl             = true
  sensitive       = false
  workspace_id    = tfe_workspace.childs[0].id

  lifecycle {
    ignore_changes = [
      value
    ]
  }

  depends_on = [tfe_workspace.childs[0]]
}
