module "eks_cluster" {
  source = "../../resource_module/eks"

  cluster_name = var.cluster_name
  vpc_id       = var.vpc_id
  subnets      = var.subnets

  worker_groups = var.worker_groups

  map_roles = var.map_roles
  map_users = var.map_users
  kubeconfig_aws_authenticator_env_variables = var.kubeconfig_aws_authenticator_env_variables

  tags = var.tags
}
