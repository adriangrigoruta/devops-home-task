data "terraform_remote_state" "eks" {
  backend   = "s3"

  config = {
    bucket          = "galactic-tf-state"
    dynamodb_table  = "galactic-tf-state-lock-dynamo"
    key             = "eks/terraform.tfsate"
    region          = "eu-west-2"
  }
}

data "azurerm_kubernetes_cluster" "credentials" {
  name                = data.terraform_remote_state.eks.outputs.name
}