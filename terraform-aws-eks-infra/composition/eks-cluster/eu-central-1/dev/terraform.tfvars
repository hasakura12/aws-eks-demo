## Provider ##
region     = "eu-central-1"
account_id = "024116961498"
role_name  = "Admin"
profile_name = "cr-labs-hisashi"

## EKS ##
cluster_name      = "eks-terraform-demo"
worker_group_tags = {}

# if set to true, AWS IAM Authenticator will use IAM role specified in "role_name" to authenticate to a cluster
authenticate_using_role = false

# if set to true, AWS IAM Authenticator will use AWS Profile name specified in profile_name to authenticate to a cluster instead of access key and secret access key
authenticate_using_aws_profile = false

# add other IAM users who can access a K8s cluster (by default, the IAM user who created a cluster is given access already)
# map_users    = [
#   {
#     user_arn = "arn:aws:iam::024116961498:user/hisashi"
#     username = "admin"
#     group    = "system:masters"
#   },
# ]

# how many groups of K8s worker nodes you want? Specify at least one group of worker node
worker_groups = [
    {
      name                 = "worker-group-1"
      instance_type        = "m3.large"
      asg_max_size         = 2
      asg_desired_capacity = 1
    },
    # {
    #   name                 = "worker-group-2"
    #   instance_type        = "m3.large"
    #   asg_max_size         = 2
    #   asg_desired_capacity = 1
    # },
]

## VPC ##
vpc_name             = "vpc-eks-terraform-demo"
cidr                 = "10.0.0.0/16"
azs                  = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
public_subnets       = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_subnets      = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
enable_dns_hostnames = "true"
enable_dns_support   = "true"
enable_nat_gateway   = "true" # need internet connection for worker nodes in private subnets to be able to join the cluster 
single_nat_gateway   = "true"

## Metadata ##
env      = "dev"
app_name = "eks-terraform-demo"