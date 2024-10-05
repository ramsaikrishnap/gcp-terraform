output "sqlserver_instances" {
  description = "A map of the created SQL Server database instances"
  value = {
    for name, instance in google_sql_database_instance.sql_server :
    name => {
      name      = instance.name
      version   = instance.database_version
      self_link = instance.self_link
    }
  }
}

output "sqlserver_connections" {
  description = "Connection details for the SQL Server databases"
  value = {
    for name, instance in google_sql_database_instance.sql_server :
    name => {
      connection_name = instance.connection_name
      public_ip       = instance.public_ip_address
      private_ip      = instance.private_ip_address
    }
  }
  sensitive = true
}