########################################
# AWS Terraform backend composition
########################################

module "backend" {
  source                    = "../../infrastructure_module/terraform_backend"
  environment_name          = "${var.environment_name}"
  app_name                  = "${var.app_name}"
  region                    = "${var.region}"
  tags                      = "${local.tags}"
  acl                       = "${var.acl}"
  force_destroy             = "${var.force_destroy}"
  versioning_enabled        = "${var.versioning_enabled}"
  versioning_mfa_delete     = "${var.versioning_mfa_delete}"
  sse_algorithm             = "${var.sse_algorithm}"
  block_public_policy       = "${var.block_public_policy}"
  block_public_acls         = "${var.block_public_acls}"
  ignore_public_acls        = "${var.ignore_public_acls}"
  restrict_public_buckets   = "${var.restrict_public_buckets}"
  read_capacity             = "${var.read_capacity}"
  write_capacity            = "${var.write_capacity}"
  hash_key                  = "${var.hash_key}"
  attribute                 = "${var.attribute}"
  sse_enabled               = "${var.sse_enabled}"
}
