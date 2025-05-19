output "cluster_database_name" {
  description = "Name for an automatically created database on cluster creation"
  value       = module.aurora-postgresql.cluster_database_name
}

output "cluster_port" {
  description = "The database port"
  value       = module.aurora-postgresql.cluster_port
}

output "cluster_master_user_secret" {
  description = "The generated database master user secret when `manage_master_user_password` is set to `true`"
  value       = module.aurora-postgresql.cluster_master_user_secret
}
