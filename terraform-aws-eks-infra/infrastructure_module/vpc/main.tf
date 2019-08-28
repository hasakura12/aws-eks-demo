module "vpc" {
  source = "../../resource_module/network/vpc"

  name = var.name
  cidr = var.cidr

  azs = var.azs
  private_subnets = var.private_subnets
  public_subnets = var.public_subnets

  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = var.single_nat_gateway

  tags = var.tags
  public_subnet_tags = local.public_subnet_tags
  private_subnet_tags = local.private_subnet_tags

}

# module "security_group" {
#   source = "../../resource_module/compute/security_group"

#   name        = local.security_group_name
#   description = local.security_group_description
#   vpc_id      = module.vpc.vpc_id

#   ingress_with_cidr_blocks = var.ingress_with_cidr_blocks
#   ingress_rules            = ["https-443-tcp"]
#   egress_rules             = ["all-all"]

#   tags = local.security_group_tags
# }