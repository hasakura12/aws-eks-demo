########################################
# Variables
########################################

variable "environment_name" {
  description = "The name of the environment."
  type        = "string"
}

variable "account_id" {
  type = "string"
}

variable "region" {
  type = "string"
}

variable "role_name" {
  type = "string"
}

variable "application_name" {
  description = "The name of the application."
  type        = "string"
}

variable "app_name" {
  description = "The name of the application."
  type        = "string"
}

variable "acl" {
  description = "The canned ACL to apply."
  type        = "string"
}

variable "force_destroy" {
  description = "A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
  type        = "string"
}

variable "versioning_enabled" {
  description = "Enable versioning. Once you version-enable a bucket, it can never return to an unversioned state."
  type        = "string"
}

variable "versioning_mfa_delete" {
  description = "Enable MFA delete for either Change the versioning state of your bucket or Permanently delete an object version."
  type        = "string"
}

variable "sse_algorithm" {
  description = "The server-side encryption algorithm to use. Valid values are AES256 and aws:kms"
  type        = "string"
}

variable "block_public_policy" {
  description = "Whether Amazon S3 should block public bucket policies for this bucket."
  type        = "string"
}

variable "block_public_acls" {
  description = "Whether Amazon S3 should ignore public ACLs for this bucket."
  type        = "string"
}

variable "ignore_public_acls" {
  description = "Whether Amazon S3 should ignore public ACLs for this bucket."
  type        = "string"
}

variable "restrict_public_buckets" {
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket."
  type        = "string"
}

variable "read_capacity" {
  description = "The number of read units for this table."
  type        = "string"
}

variable "write_capacity" {
  description = "The number of write units for this table."
  type        = "string"
}

variable "hash_key" {
  description = "The attribute to use as the hash (partition) key."
  type        = "string"
}

variable "attribute" {
  description = "List of nested attribute definitions. Only required for hash_key and range_key attributes."
  type        = "list"
}

variable "sse_enabled" {
  description = "Encryption at rest using an AWS managed Customer Master Key. If enabled is false then server-side encryption is set to AWS owned CMK (shown as DEFAULT in the AWS console). If enabled is true then server-side encryption is set to AWS managed CMK (shown as KMS in the AWS console). ."
  type        = "string"
}