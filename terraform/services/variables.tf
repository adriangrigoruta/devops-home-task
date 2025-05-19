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
  default = "services"
}
variable "default_tags" {
  type = map
  default = {
    Project     = "galactic"
    Application = "services"
    Automate    = "terraform"
  }
}

# Project variables
# ------------------------------------
variable "domain_name" {
  type = string
  default = "galactic.io"
}

# Local variables
# --------------------------
locals {
  environment     = terraform.workspace
  stack_name      = "${var.project}-${var.application}-${terraform.workspace}"

  # Local variables prefixed with 'env_' are environment dependant
  env_tags        = merge(var.default_tags, tomap({"Environment" = local.environment}))
}