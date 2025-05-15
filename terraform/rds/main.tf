module "aurora-postgresql" {
  source  = "terraform-aws-modules/rds-aurora/aws"

  name            = "${var.project}-${var.application}-postgresql"
  engine          = "aurora-postgresql"
  engine_version  = "16.6"
  master_username = "${var.project}admin"
  database_name   = "users"

  instance_class      = "db.t3.medium"
  instances = {
    1   = {}
    2   = {}
  }

  vpc_id               = data.terraform_remote_state.vpc.outputs.vpc_id
  db_subnet_group_name = data.terraform_remote_state.vpc.outputs.vpc_name
  security_group_rules = {
    vpc_ingress = {
      cidr_blocks = data.terraform_remote_state.vpc.outputs.private_subnets_cidr_block
    }
  }
  availability_zones    = data.terraform_remote_state.vpc.outputs.vpc_azs

  create_db_subnet_group  = false
  skip_final_snapshot     = true
  storage_encrypted       = true
  apply_immediately       = true
  backup_retention_period = 7

  tags = local.env_tags
}