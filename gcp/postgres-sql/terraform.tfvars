project_id = "your-gcp-project-id"
region     = "us-central1"

postgres_databases = {
  "postgres-db-1" = {
    version  = "POSTGRES_13"
    tier     = "db-f1-micro"
    size     = 10
    ha       = false
    replicas = 0
  },
  "postgres-db-2" = {
    version  = "POSTGRES_12"
    tier     = "db-n1-standard-1"
    size     = 20
    ha       = true
    replicas = 1
  }
}