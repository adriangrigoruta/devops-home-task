data "terraform_remote_state" "eks" {
  backend   = "s3"

  config = {
    bucket          = "galactic-tf-state"
    dynamodb_table  = "galactic-tf-state-lock-dynamo"
    key             = "eks/terraform.tfsate"
    region          = "eu-west-2"
  }
}

data "terraform_remote_state" "vpc" {
  backend   = "s3"

  config = {
    bucket          = "galactic-tf-state"
    dynamodb_table  = "galactic-tf-state-lock-dynamo"
    key             = "vpc/terraform.tfsate"
    region          = "eu-west-2"
  }
}

data "terraform_remote_state" "rds" {
  backend   = "s3"

  config = {
    bucket          = "galactic-tf-state"
    dynamodb_table  = "galactic-tf-state-lock-dynamo"
    key             = "rds/terraform.tfsate"
    region          = "eu-west-2"
  }
}

data "aws_eks_cluster" "eks" {
  name = "${var.project}-eks"
}

data "aws_eks_cluster_auth" "auth" {
  name = "${var.project}-eks"
}
