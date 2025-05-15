data "terraform_remote_state" "vpc" {
  backend   = "s3"

  config = {
    bucket          = "galactic-tf-state"
    dynamodb_table  = "galactic-tf-state-lock-dynamo"
    key             = "vpc/terraform.tfsate"
    region          = "eu-west-2"
  }
}