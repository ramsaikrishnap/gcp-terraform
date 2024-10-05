project_id = "your-gcp-project-id"
region     = "us-central1"

mysql_databases = {
  "mysql-db-1" = {
    version  = "MYSQL_8_0"
    tier     = "db-f1-micro"
    size     = 10
    ha       = false
    replicas = 0
  },
  "mysql-db-2" = {
    version  = "MYSQL_5_7"
    tier     = "db-n1-standard-1"
    size     = 20
    ha       = true
    replicas = 1
  }
}