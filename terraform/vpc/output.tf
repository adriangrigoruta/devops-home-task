output "private_subnets" {
  value = module.vpc.private_subnets
}

output "private_subnets_cidr_block" {
  value = module.vpc.private_subnets_cidr_blocks
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "public_subnets_cidr_block" {
  value = module.vpc.public_subnets_cidr_blocks
}

output "database_subnets" {
  value = module.vpc.database_subnets
}
output "database_subnets_cidr_block" {
  value = module.vpc.database_subnets_cidr_blocks
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_name" {
  value = module.vpc.name
}

output "vpc_azs" {
  value = module.vpc.azs
}