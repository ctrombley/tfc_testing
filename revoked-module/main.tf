module "module" {
  source  = "tfcdev-781a2fe5.ngrok.io/trombs-test-org/module/example"
  version = "1.0.2"
}

resource "null_resource" "null" {
  triggers = {
    module_version = module.module.version
  }
}
