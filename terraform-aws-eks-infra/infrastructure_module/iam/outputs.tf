########################################
# IAM Role
########################################
output "role_name" {
  description = "The name of the role."
  value       = "${module.k8s_iam_role.name}"
}

output "role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the role."
  value       = "${module.k8s_iam_role.arn}"
}
