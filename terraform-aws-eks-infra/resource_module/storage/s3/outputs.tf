########################################
# Outputs
########################################

output "id" {
  description = "The name of the bucket."
  value       = "${aws_s3_bucket.this.id}"
}

output "arn" {
  description = "The ARN of the bucket."
  value       = "${aws_s3_bucket.this.arn}"
}
