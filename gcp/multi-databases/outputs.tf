output "database_instances" {
  description = "A map of the created database instances"
  value = {
    for name, instance in merge(
      google_sql_database_instance.mysql,
      google_sql_database_instance.postgres,
      google_sql_database_instance.sql_server
    ) :
    name => {
      name     = instance.name
      type     = split("-", instance.database_version)[0]
      version  = instance.database_version
      self_link = instance.self_link
    }
  }
}

output "database_connections" {
  description = "Connection details for the databases"
  value = {
    for name, instance in merge(
      google_sql_database_instance.mysql,
      google_sql_database_instance.postgres,
      google_sql_database_instance.sql_server
    ) :
    name => {
      connection_name = instance.connection_name
      public_ip       = instance.public_ip_address
      private_ip      = instance.private_ip_address
    }
  }
  sensitive = true
}