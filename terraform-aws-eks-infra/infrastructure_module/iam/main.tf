module "k8s_iam_role" {
  source                      = "../../resource_module/identity/iam/role"
  name                        = "${local.k8s_iam_role_name}"
  tags                        = "${local.k8s_iam_role_tags}"
  assume_role_policy_name     = "${local.k8s_iam_role_assume_role_policy_name}"
  assume_role_policy_document = "${data.aws_iam_policy_document.k8s_iam_role_assume_role_policy_document.json}"
  policies                    = "${local.k8s_iam_role_policies}"
  policies_count              = "${local.k8s_iam_role_policies_count}"
  policies_arns               = ["${data.aws_iam_policy.eks_cluster_policy.arn}", "${data.aws_iam_policy.eks_service_policy.arn}"]
}