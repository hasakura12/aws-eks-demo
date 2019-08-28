## PROVIDER ##
variable "region" {}
variable "account_id" {}
variable "role_name" {}
variable "profile_name" {}

## EKS ##
variable "cluster_name" {
}

variable "worker_groups" {
  type        = any
  default     = []
}

variable "worker_group_tags" {
  type = map(string)
}

variable "authenticate_using_role" {
  description = "if set to true, AWS IAM Authenticator will use IAM role specified in role_name to authenticate to a cluster"
}

variable "authenticate_using_aws_profile" {
  description = "if set to true, AWS IAM Authenticator will use AWS Profile name specified in profile_name to authenticate to a cluster instead of access key and secret access key"
}

variable "map_roles" { 
  type = list(map(string))
  default = []
}

variable "map_users" { 
  type = list(map(string))
  default = []
}

## VPC ##
variable "vpc_name" {
  description = "Name to be used on all the resources as identifier"
  default     = ""
}

variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  default     = "0.0.0.0/0"
}

variable "azs" {
  description = "Number of availability zones to use in the region"
  type        = list(string)
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  default     = []
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  default     = []
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  default     = true
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  default     = true
}

variable "enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
  default     = true
}

variable "single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  default     = true
}

## Metatada ##
variable "env" {}
variable "app_name" {}