variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "region" {
  description = "The region to create resources in"
  type        = string
}

variable "mysql_databases" {
  description = "A map of MySQL database configurations"
  type = map(object({
    version  = string
    tier     = string
    size     = number
    ha       = bool
    replicas = number
  }))
}