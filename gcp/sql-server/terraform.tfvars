project_id = "your-gcp-project-id"
region     = "us-central1"

sqlserver_databases = {
  "sqlserver-db-1" = {
    version  = "SQLSERVER_2019_STANDARD"
    tier     = "db-custom-2-3840"
    size     = 20
    ha       = false
    replicas = 0
  },
  "sqlserver-db-2" = {
    version  = "SQLSERVER_2017_ENTERPRISE"
    tier     = "db-custom-4-15360"
    size     = 50
    ha       = true
    replicas = 1
  }
}