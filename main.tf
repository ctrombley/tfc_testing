terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

check "terraform_io_certificate" {
  data "tls_certificate" "terraform_io" {
    url = "https://www.terraform.io/"
  }

  assert {
    condition = timecmp(plantimestamp(), data.tls_certificate.terraform_io.certificates[0].not_after) < 0
    error_message = "terraform.io certificate has expired"
  }
}
