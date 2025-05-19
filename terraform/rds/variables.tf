# Global variables
# --------------------------

variable "location" {
  type    = string
  default = "eu-west-2"
}
variable "project" {
  type    = string
  default = "galactic"
}
variable "application" {
  type    = string
  default = "rds"
}
variable "default_tags" {
  type = map
  default = {
    Project     = "galactic"
    Application = "rds"
    Automate    = "terraform"
  }
}

# Project variables
# 10.X.0.0 - 10.X.255.255
# ------------------------------------


# Local variables
# --------------------------
locals {
  environment     = terraform.workspace
  stack_name      = "${var.project}-${var.application}-${terraform.workspace}"

  # Local variables prefixed with 'env_' are environment dependant
  env_tags        = merge(var.default_tags, tomap({"Environment" = local.environment}))
}

variable "db_name" {
  type = string
  default = "users"
}

variable "db_user" {
  type = string
  default = "galacticadmin"
}