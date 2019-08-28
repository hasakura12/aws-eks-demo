locals {
  ## VPC ##  
  # vpc_tags = "${merge(var.tags, map("Name", "vpc-${var.region_tag[var.aws_region]}-${var.app_name}-${var.environment_tag[var.env]}"))}"

  ## Domain Controllers SG ##
  security_group_name        = "scg-${var.region_tag[var.region]}-${var.environment_tag[var.env]}-${var.app_name}"
  security_group_description = "Security group for ${var.app_name}"

  security_group_tags = merge(
    var.tags,
    {
      "Name" = "scg-${var.region_tag[var.region]}-${var.environment_tag[var.env]}-${var.app_name}"
    },
    {
      "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    }
  )

  // need to tag public subnet with "shared" so K8s can find right subnets to create ELBs
  // https://github.com/kubernetes/kubernetes/issues/29298
  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  # need tag for internal-elb to be able to create ELB
  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "true"
  }
}