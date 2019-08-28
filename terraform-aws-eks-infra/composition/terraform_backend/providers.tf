########################################
# Provider to connect to AWS
#
# https://www.terraform.io/docs/providers/aws/
########################################

terraform {
  required_version = ">= 0.12"
  backend          "s3"             {}
}

provider "aws" {
  version = "~> 2.7.0"
  region  = "${var.region}"

  assume_role {
    role_arn = "arn:aws:iam::${var.account_id}:role/${var.role_name}"
  }
}
