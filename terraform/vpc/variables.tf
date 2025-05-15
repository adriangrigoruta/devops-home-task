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
  default = "vpc"
}
variable "default_tags" {
  type = map
  default = {
    Project     = "galactic"
    Application = "vpc"
    Automate    = "terraform"
  }
}

# Project variables
# 10.X.0.0 - 10.X.255.255
# ------------------------------------
variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "vpc_azs" {
  default = ["eu-west-2a", "eu-west-2b"]
}

variable "vpc_private_subnets" {
  default = ["10.0.0.0/23", "10.0.2.0/23"]
}

variable "vpc_public_subnets" {
  default = ["10.0.4.0/23", "10.0.6.0/23"]
}

variable "vpc_database_subnets" {
  default = ["10.0.8.0/23", "10.0.10.0/23"]
}

# Local variables
# --------------------------
locals {
  environment     = terraform.workspace
  stack_name      = "${var.project}-${var.application}-${terraform.workspace}"

  # Local variables prefixed with 'env_' are environment dependant
  env_tags        = merge(var.default_tags, tomap({"Environment" = local.environment}))
}