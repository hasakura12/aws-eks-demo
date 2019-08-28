########################################
# AWS INSTANCE
########################################
locals {
  this_id                           = "${compact(concat(coalescelist(aws_instance.this.*.id, aws_instance.this_t2.*.id), list("")))}"
  this_availability_zone            = "${compact(concat(coalescelist(aws_instance.this.*.availability_zone, aws_instance.this_t2.*.availability_zone), list("")))}"
  this_key_name                     = "${compact(concat(coalescelist(aws_instance.this.*.key_name, aws_instance.this_t2.*.key_name), list("")))}"
  this_public_dns                   = "${compact(concat(coalescelist(aws_instance.this.*.public_dns, aws_instance.this_t2.*.public_dns), list("")))}"
  this_public_ip                    = "${compact(concat(coalescelist(aws_instance.this.*.public_ip, aws_instance.this_t2.*.public_ip), list("")))}"
  this_primary_network_interface_id = "${compact(concat(coalescelist(aws_instance.this.*.primary_network_interface_id, aws_instance.this_t2.*.primary_network_interface_id), list("")))}"
  this_private_dns                  = "${compact(concat(coalescelist(aws_instance.this.*.private_dns, aws_instance.this_t2.*.private_dns), list("")))}"
  this_private_ip                   = "${compact(concat(coalescelist(aws_instance.this.*.private_ip, aws_instance.this_t2.*.private_ip), list("")))}"
  this_security_groups              = "${compact(concat(coalescelist(flatten(aws_instance.this.*.security_groups), flatten(aws_instance.this_t2.*.security_groups)), list("")))}"
  this_vpc_security_group_ids       = "${compact(concat(coalescelist(flatten(aws_instance.this.*.vpc_security_group_ids), flatten(aws_instance.this_t2.*.vpc_security_group_ids)), list("")))}"
  this_subnet_id                    = "${compact(concat(coalescelist(aws_instance.this.*.subnet_id, aws_instance.this_t2.*.subnet_id), list("")))}"
  this_credit_specification         = "${aws_instance.this_t2.*.credit_specification}"
  this_tags                         = "${coalescelist(flatten(aws_instance.this.*.tags), flatten(aws_instance.this_t2.*.tags))}"
}

output "id" {
  value       = ["${local.this_id}"]
  description = "The instance ID."
}

output "arn" {
  value       = "${aws_instance.this.*.arn}"
  description = "The ARN of the instance."
}

output "availability_zone" {
  value       = ["${local.this_availability_zone}"]
  description = "The availability zone of the instance."
}

output "placement_group" {
  value       = "${aws_instance.this.*.placement_group}"
  description = "The placement group of the instance."
}

output "key_name" {
  value       = "${aws_instance.this.*.key_name}"
  description = "The key name of the instance"
}

output "password_data" {
  value       = "${aws_instance.this.*.password_data}"
  description = "Base-64 encoded encrypted password data for the instance. Useful for getting the administrator password for instances running Microsoft Windows. This attribute is only exported if get_password_data is true. Note that this encrypted value will be stored in the state file, as with all exported attributes. See GetPasswordData for more information."
}

output "public_dns" {
  value       = ["${local.this_public_dns}"]
  description = "The public DNS name assigned to the instance. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC"
}

output "public_ip" {
  value       = ["${local.this_public_ip}"]
  description = "The public IP address assigned to the instance, if applicable. NOTE: If you are using an aws_eip with your instance, you should refer to the EIP's address directly and not use public_ip, as this field will change after the EIP is attached."
}

output "primary_network_interface_id" {
  value       = ["${local.this_primary_network_interface_id}"]
  description = "The ID of the instance's primary network interface."
}

output "private_dns" {
  value       = ["${local.this_private_dns}"]
  description = "The private DNS name assigned to the instance. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC"
}

output "private_ip" {
  value       = ["${local.this_private_ip}"]
  description = "The private IP address assigned to the instance"
}

output "security_groups" {
  value       = ["${local.this_security_groups}"]
  description = "The associated security groups."
}

output "vpc_security_group_ids" {
  value       = ["${local.this_vpc_security_group_ids}"]
  description = "The associated security groups in non-default VPC"
}

output "subnet_id" {
  value       = ["${local.this_subnet_id}"]
  description = "The VPC subnet ID."
}
