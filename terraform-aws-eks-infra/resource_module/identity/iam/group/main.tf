########################################
# AWS IAM Group resource
#
# https://www.terraform.io/docs/providers/aws/r/iam_group.html
########################################

resource "aws_iam_group" "this" {
  name = "${var.name}"
}

resource "aws_iam_group_policy_attachment" "this" {
  count      = "${length(var.policies_arns)}"
  group      = "${aws_iam_group.this.name}"
  policy_arn = "${var.policies_arns[count.index]}"
}
