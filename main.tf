terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

check "valid_certificate" {
  data "tls_certificate" "valid" {
    url = "https://www.terraform.io/"
  }

  assert {
    condition = timecmp(plantimestamp(), data.tls_certificate.valid.certificates[0].not_after) < 0
    error_message = "SSL certificate has expired"
  }
}

check "expired_certificate" {
  data "tls_certificate" "expired" {
    url = "https://expired-rsa-dv.ssl.com/"
  }

  assert {
    condition = timecmp(plantimestamp(), data.tls_certificate.expired.certificates[0].not_after) < 0
    error_message = "SSL certificate has expired"
  }
}
