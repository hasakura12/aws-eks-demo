variable "key_name" {
  description = "(Optional) The name for the key pair."
  type        = "string"
}

variable "public_key" {
  description = "(Required) The public key material. "
  type        = "string"
}
