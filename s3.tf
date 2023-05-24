data "aws_region" "current" {}

resource "aws_s3_bucket" "geoblock_page" {
  force_destroy = false

  bucket = "hc1-network-perimeter-prod-geoblock-page-${data.aws_region.current.name}"
}

resource "aws_s3_bucket_versioning" "geoblock_page" {
  bucket = aws_s3_bucket.geoblock_page.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "geoblock_page" {
  bucket = aws_s3_bucket.geoblock_page.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "geoblock_page" {
  bucket = aws_s3_bucket.geoblock_page.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_public_access_block" "geoblock_page" {
  bucket = aws_s3_bucket.geoblock_page.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
