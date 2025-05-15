# S3 backend initially commented
# uncomment and re-init tf after creating the S3 bucket

terraform {
  required_version = ">= 1.4.0"

  backend "s3" {
    bucket          = "galactic-tf-state"
    dynamodb_table  = "galactic-tf-state-lock-dynamo"
    key             = "terraform.tfstate"
    region          = "eu-west-2"
    encrypt         = true
    max_retries     = 30
  }
}