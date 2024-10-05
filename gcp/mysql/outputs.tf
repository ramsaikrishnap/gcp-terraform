output "mysql_instances" {
  description = "A map of the created MySQL database instances"
  value = {
    for name, instance in google_sql_database_instance.mysql :
    name => {
      name      = instance.name
      version   = instance.database_version
      self_link = instance.self_link
    }
  }
}

output "mysql_connections" {
  description = "Connection details for the MySQL databases"
  value = {
    for name, instance in google_sql_database_instance.mysql :
    name => {
      connection_name = instance.connection_name
      public_ip       = instance.public_ip_address
      private_ip      = instance.private_ip_address
    }
  }
  sensitive = true
}