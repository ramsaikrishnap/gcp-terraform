variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "region" {
  description = "The region to create resources in"
  type        = string
}

variable "databases" {
  description = "A map of database configurations"
  type = map(object({
    type     = string
    version  = string
    tier     = string
    size     = number
    ha       = bool
    replicas = number
  }))
}