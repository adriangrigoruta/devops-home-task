terraform {
  required_version = ">= 1.4.0"

  backend "s3" {
    bucket          = "galactic-tf-state"
    dynamodb_table  = "galactic-tf-state-lock-dynamo"
    key             = "s3/terraform.tfsate"
    region          = "eu-west-2"
    encrypt         = true
    max_retries     = 30
  }
}