########################################
# Variables
########################################

variable "name" {
  description = "The group's name. The name must consist of upper and lowercase alphanumeric characters with no spaces."
  type        = "string"
}

variable "policies_arns" {
  description = "The list of ARN of the policies you want to apply."
  type        = "list"
}
