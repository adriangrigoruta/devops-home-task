module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.project}-${var.application}"
  cidr = var.vpc_cidr

  azs                 = var.vpc_azs
  private_subnets     = var.vpc_private_subnets
  public_subnets      = var.vpc_public_subnets
  database_subnets    = var.vpc_database_subnets

  create_database_subnet_group        = true
  create_database_subnet_route_table  = true
  enable_nat_gateway = true
  enable_vpn_gateway = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }

  tags = local.env_tags
}