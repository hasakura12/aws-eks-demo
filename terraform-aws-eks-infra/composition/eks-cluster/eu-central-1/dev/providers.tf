provider "aws" {
  version = "~> 2.11"
  region  = var.region
  profile = "cr-labs-hisashi"

  # assume_role {
  #   role_arn = "arn:aws:iam::${var.account_id}:role/${var.role_name}"
  # }
}

provider "local" {
  version = "~> 1.2"
}

provider "null" {
  version = "~> 2.1"
}

provider "template" {
  version = "~> 2.1"
}

