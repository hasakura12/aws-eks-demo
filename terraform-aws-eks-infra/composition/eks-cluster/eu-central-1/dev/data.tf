locals {

  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.private_subnets
  map_roles = var.authenticate_using_role == true ? concat(var.map_roles, [
    {
      role_arn = "arn:aws:iam::${var.account_id}:role/${var.role_name}"
      username = "role1"
      group    = "system:masters"
    },
  ]) : var.map_roles

  # specify AWS Profile if you want kubectl to use a named profile to authenticate instead of access key and secret access key
  kubeconfig_aws_authenticator_env_variables = var.authenticate_using_aws_profile == true ? {
    AWS_PROFILE = var.profile_name
  } : {}

  tags = {
    Environment = var.env
    Application = var.app_name
  }
}

# data "terraform_remote_state" "base" {
#   backend = "s3"

#   config = {
#     bucket   = var.bucket_name
#     key      = var.key
#     region   = var.region
#     role_arn = "arn:aws:iam::${var.account_id}:role/${var.role_name}"
#   }
# }