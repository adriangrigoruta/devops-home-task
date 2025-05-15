#resource "kubernetes_secret" "rds_connection_string" {
#  metadata {
#    name      = "rds-connection-string"
#    namespace = "default"
#  }
#
#  data = {
#    username = var.rds_username
#    password = aws_db_instance.my_rds.password
#  }
#
#  type = "Opaque"
#}
