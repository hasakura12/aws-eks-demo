########################################
# AWS Terraform backend infrastructure
########################################

# Encrypted S3 Bucket
module "s3" {
  source                    = "../../resource_module/storage/s3"
  bucket                    = "${local.bucket_name}"
  region                    = "${var.region}"
  acl                       = "${var.acl}"
  force_destroy             = "${var.force_destroy}"
  versioning_enabled        = "${var.versioning_enabled}"
  versioning_mfa_delete     = "${var.versioning_mfa_delete}"
  sse_algorithm             = "${var.sse_algorithm}"
  tags                      = "${var.tags}"
  policy                    = "${data.aws_iam_policy_document.bucket_policy.json}"
  block_public_policy       = "${var.block_public_policy}"
  block_public_acls         = "${var.block_public_acls}"
  ignore_public_acls        = "${var.ignore_public_acls}"
  restrict_public_buckets   = "${var.restrict_public_buckets}"
}