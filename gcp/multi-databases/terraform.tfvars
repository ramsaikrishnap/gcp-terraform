project_id = "your-gcp-project-id"
region     = "us-central1"

databases = {
  "mysql-db" = {
    type     = "MYSQL"
    version  = "MYSQL_8_0"
    tier     = "db-f1-micro"
    size     = 10
    ha       = false
    replicas = 0
  },
  "postgres-db" = {
    type     = "POSTGRES"
    version  = "POSTGRES_13"
    tier     = "db-f1-micro"
    size     = 10
    ha       = true
    replicas = 1
  },
  "sqlserver-db" = {
    type     = "SQL_SERVER"
    version  = "SQLSERVER_2019_STANDARD"
    tier     = "db-custom-2-3840"
    size     = 20
    ha       = false
    replicas = 0
  }
}