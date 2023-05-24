data "aws_iam_policy_document" "geoblock_page_github_actions_trust_policy" {
  statement {
    actions = [
      "sts:AssumeRole",
      "sts:SetSourceIdentity",
      "sts:TagSession"
    ]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::397512762488:user/doormatServiceUser"]
    }
  }
}

data "aws_iam_policy_document" "geoblock_page_github_actions_permissions_policy" {
  statement {
    actions = [
      "s3:PutObject"
    ]
    resources = ["${aws_s3_bucket.geoblock_page.arn}/*"]
  }
}

resource "aws_iam_role" "geoblock_page_github_actions" {
  name = "GHA-GeoBlock-Page"

  inline_policy {
    name   = "allow_putobject_to_cli_releases_buckets"
    policy = data.aws_iam_policy_document.geoblock_page_github_actions_permissions_policy.json
  }
  assume_role_policy = data.aws_iam_policy_document.geoblock_page_github_actions_trust_policy.json

  tags = {
    hc-service-uri = "github.com/hashicorp/geoblock-page@event_name=pull_request:base_ref=main///event_name=push:ref=refs/heads/main"
  }
}
