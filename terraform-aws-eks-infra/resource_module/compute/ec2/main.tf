######
# Note: network_interface can't be specified together with associate_public_ip_address
######
resource "aws_instance" "this" {
  count = "${var.instance_count}"

  ami                    = "${var.ami}"
  instance_type          = "${var.instance_type}"
  user_data              = "${var.user_data}"
  subnet_id              = "${var.subnet_id}"
  key_name               = "${var.key_name}"
  monitoring             = "${var.monitoring}"
  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
  iam_instance_profile   = "${var.iam_instance_profile}"

  associate_public_ip_address = "${var.associate_public_ip_address}"
  private_ip                  = "${var.private_ip}"

  ebs_optimized          = "${var.ebs_optimized}"
  root_block_device      = "${var.root_block_device}"
  ephemeral_block_device = "${var.ephemeral_block_device}"

  source_dest_check                    = "${var.source_dest_check}"
  disable_api_termination              = "${var.disable_api_termination}"
  instance_initiated_shutdown_behavior = "${var.instance_initiated_shutdown_behavior}"
  tenancy                              = "${var.tenancy}"

  tags = "${var.tags}"

  lifecycle {
    # Due to several known issues in Terraform AWS provider related to arguments of aws_instance:
    # (eg, https://github.com/terraform-providers/terraform-provider-aws/issues/2036)
    # we have to ignore changes in the following arguments
    ignore_changes = ["private_ip", "root_block_device", "ebs_block_device"]
  }
}

# resource "aws_cloudwatch_metric_alarm" "autorecover" {
#   count = "${var.instance_count}"

#   alarm_name          = "${var.alarm_name}"
#   namespace           = "${var.namespace}"
#   evaluation_periods  = "${var.evaluation_periods}"
#   period              = "${var.period}"
#   alarm_description   = "${var.alarm_description}"
#   alarm_actions       = "${var.alarm_actions}"
#   statistic           = "${var.statistic}"
#   comparison_operator = "${var.comparison_operator}"
#   threshold           = "${var.threshold}"
#   metric_name         = "${var.metric_name}"
#   dimensions {
#       InstanceId = "${aws_instance.this.id[count.index]}"
#   }
# }

resource "aws_volume_attachment" "this" {
  count       = "${length(var.ebs_volumes)}"
  device_name = "${lookup(var.ebs_volumes[count.index], "device_name")}"
  volume_id   = "${aws_ebs_volume.this.*.id[count.index]}"
  instance_id = "${aws_instance.this.id}"
}

resource "aws_ebs_volume" "this" {
  count             = "${length(var.ebs_volumes)}"
  availability_zone = "${aws_instance.this.availability_zone}"
  size              = "${lookup(var.ebs_volumes[count.index], "size")}"
  type              = "${lookup(var.ebs_volumes[count.index], "type")}"
  encrypted         = "${lookup(var.ebs_volumes[count.index], "encrypted")}"
  kms_key_id        = "${lookup(var.ebs_volumes[count.index], "kms_key_id")}"
  tags              = "${merge(var.tags, map("Name", "${var.ebs_volumes_name}-${count.index + 1}"))}"
}
