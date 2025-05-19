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
  default = "tf-state"
}
variable "default_tags" {
  type = map
  default = {
    Project     = "galactic"
    Application = "tf-state"
    Automate    = "terraform"
  }
}