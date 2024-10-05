resource "random_id" "db_name_suffix" {
  byte_length = 4
}

locals {
  mysql_instances       = { for k, v in var.databases : k => v if v.type == "MYSQL" }
  postgres_instances    = { for k, v in var.databases : k => v if v.type == "POSTGRES" }
  sql_server_instances  = { for k, v in var.databases : k => v if v.type == "SQL_SERVER" }
}

resource "google_sql_database_instance" "mysql" {
  for_each            = local.mysql_instances
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

resource "google_sql_database_instance" "postgres" {
  for_each            = local.postgres_instances
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

resource "google_sql_database_instance" "sql_server" {
  for_each            = local.sql_server_instances
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

resource "google_sql_database_instance" "read_replicas" {
  for_each = {
    for name, db in var.databases : name => db
    if db.replicas > 0
  }

  name                = "${each.key}-replica-${random_id.db_name_suffix.hex}"
  master_instance_name = each.value.type == "MYSQL" ? google_sql_database_instance.mysql[each.key].name : each.value.type == "POSTGRES" ? google_sql_database_instance.postgres[each.key].name : google_sql_database_instance.sql_server[each.key].name
  region              = var.region
  database_version    = each.value.version
  deletion_protection = false

  replica_configuration {
    failover_target = false
  }

  settings {
    tier      = each.value.tier
    disk_size = each.value.size
  }
}