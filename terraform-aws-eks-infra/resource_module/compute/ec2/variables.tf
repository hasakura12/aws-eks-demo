variable "instance_count" {}

variable "ami" {
  type = "string"
}

variable "instance_type" {
  type = "string"
}

variable "user_data" {
  type = "string"
}

variable "subnet_id" {
  type = "string"
}

variable "key_name" {
  type = "string"
}

variable "monitoring" {
  type = "string"
}

variable "vpc_security_group_ids" {
  type = "list"
}

variable "iam_instance_profile" {
  type = "string"
}

variable "associate_public_ip_address" {
  type = "string"
}

variable "private_ip" {
  type = "string"
}

variable "ebs_optimized" {
  type = "string"
}

variable "volume_tags" {
  type = "map"
}

variable "root_block_device" {
  type = "list"
}

variable "ebs_block_device" {
  type = "list"
}

variable "ebs_volumes" {
  default = []
}

variable "ebs_volumes_name" {
  default = ""
}

variable "ephemeral_block_device" {
  type = "list"
}

variable "source_dest_check" {
  type = "string"
}

variable "disable_api_termination" {
  type = "string"
}

variable "instance_initiated_shutdown_behavior" {
  type = "string"
}

variable "tenancy" {
  type = "string"
}

variable "tags" {
  type = "map"
}

## Cloud Watch Alarm ##
variable "alarm_name" {}

variable "namespace" {}
variable "evaluation_periods" {}
variable "period" {}
variable "alarm_description" {}

variable "alarm_actions" {
  type = "list"
}

variable "statistic" {}
variable "comparison_operator" {}
variable "threshold" {}
variable "metric_name" {}
