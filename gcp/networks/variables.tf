variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "region" {
  description = "The region to create resources in"
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "subnets" {
  description = "A map of subnet configurations"
  type = map(object({
    cidr_range = string
    region     = string
    private    = bool
  }))
}