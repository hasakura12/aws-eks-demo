########################################
# Environment setting
########################################

region = "eu-central-1"

role_name = "Admin"

environment_name = "dev"

application_name = "eks-terraform"

account_id = "024116961498"

app_name = "eks-terraform"

acl = "private"

force_destroy = false

versioning_enabled = false

versioning_mfa_delete = false

sse_algorithm = "AES256"

block_public_policy = true

block_public_acls = true

ignore_public_acls = true

restrict_public_buckets = true

read_capacity = 5

write_capacity = 5

hash_key = "LockID"

sse_enabled = false

attribute = [{
  name = "LockID"
  type = "S"
}]
