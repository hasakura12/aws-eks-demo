terraform {
  backend "s3" {}
}

module "eks" {
  source = "../../../../infrastructure_module/eks"

  cluster_name = var.cluster_name
  vpc_id       = local.vpc_id
  subnets      = local.subnets

  worker_groups = var.worker_groups
  worker_group_tags = local.tags
  
  # add roles that can access K8s cluster
  map_roles = local.map_roles
  # add IAM users who can access K8s cluster
  map_users = var.map_users

  # specify AWS Profile if you want kubectl to use a named profile to authenticate instead of access key and secret access key
  kubeconfig_aws_authenticator_env_variables = local.kubeconfig_aws_authenticator_env_variables

  ## Common tag metadata ##
  env      = var.env
  app_name = var.app_name
  tags     = local.tags
  region   = var.region
}

module "vpc" {
  source = "../../../../infrastructure_module/vpc"

  name                 = var.vpc_name
  cidr                 = var.cidr
  azs                  = var.azs
  private_subnets      = var.private_subnets
  public_subnets       = var.public_subnets
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  enable_nat_gateway   = var.enable_nat_gateway
  single_nat_gateway   = var.single_nat_gateway

  cluster_name = var.cluster_name
  
  ## Common tag metadata ##
  env      = var.env
  app_name = var.app_name
  tags     = local.tags
  region   = var.region
}