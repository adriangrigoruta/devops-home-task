terraform {
  required_version = ">= 1.4.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region      = "eu-west-2"
}

provider "kubernetes" {
  host                   = data.azurerm_kubernetes_cluster.credentials.kube_config.0.host
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.credentials.kube_config.0.client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.credentials.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.credentials.kube_config.0.cluster_ca_certificate)
}
