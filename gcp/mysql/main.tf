resource "random_id" "db_name_suffix" {
  byte_length = 4

}
resource "google_sql_database_instance" "mysql" {
  for_each            = { for k, v in var.mysql_databases : k => v if v.type == "MYSQL" }
  name                = "${each.key}-${random_id.db_name_suffix.hex}"
  database_version    = each.value.version
  region              = var.region
  deletion_protection = false

  settings {
    tier              = each.value.tier
    availability_type = each.value.ha ? "REGIONAL" : "ZONAL"
    disk_size         = each.value.size

    backup_configuration {
      enabled = true
    }
  }
}

resource "google_sql_database_instance" "mysql_replicas" {
  for_each = {
    for name, db in var.mysql_databases : name => db
    if db.type == "MYSQL" && db.replicas > 0
  }

  name                 = "${each.key}-replica-${random_id.db_name_suffix.hex}"
  master_instance_name = google_sql_database_instance.mysql[each.key].name
  region               = var.region
  database_version     = each.value.version
  deletion_protection  = false

  replica_configuration {
    failover_target = false
  }

  settings {
    tier      = each.value.tier
    disk_size = each.value.size
  }
}