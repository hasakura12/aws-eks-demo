########################################
# Data sources
########################################

# Computed variables
locals {
  environment_tag = {
    "prod"     = "prod"
    "dev"      = "dev"
  }

  region_tag = {
    "us-east-1"    = "ue1"
    "us-west-1"    = "uw1"
    "eu-west-1"    = "ew1"
    "eu-central-1" = "ec1"
  }

  bucket_name   = "s3-${local.region_tag[var.region]}-${lower(var.app_name)}-${local.environment_tag[var.environment_name]}-terraform-states"
}

# Current account ID
data "aws_caller_identity" "current" {}

# S3 Bucket Policy
data "aws_iam_policy_document" "bucket_policy" {
  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket",
    ]

    principals {
      type = "AWS"

      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
      ]
    }

    resources = [
      "arn:aws:s3:::${local.bucket_name}",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
    ]

    principals {
      type = "AWS"

      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
      ]
    }

    resources = [
      "arn:aws:s3:::${local.bucket_name}/*",
    ]
  }
}
