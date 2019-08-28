locals {
   ## IAM Role ##
  k8s_iam_role_name                    = "k8sRole"
  k8s_iam_role_assume_role_policy_name = "${local.k8s_iam_role_name}AssumeRolePolicy"

  k8s_iam_role_policies = []

  k8s_iam_role_policies_count = 0
  k8s_iam_role_tags           = "${merge(var.tags, map("Name", local.k8s_iam_role_name))}"

}

data "aws_iam_policy_document" "k8s_iam_role_assume_role_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

data "aws_iam_policy" "eks_cluster_policy" {
  arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

data "aws_iam_policy" "eks_service_policy" {
  arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}