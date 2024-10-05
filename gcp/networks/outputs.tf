output "vpc_id" {
  description = "The ID of the created VPC"
  value       = google_compute_network.vpc.id
}

output "vpc_name" {
  description = "The name of the created VPC"
  value       = google_compute_network.vpc.name
}

output "subnets" {
  description = "A map of the created subnets"
  value = {
    for name, subnet in google_compute_subnetwork.subnets :
    name => {
      id         = subnet.id
      name       = subnet.name
      cidr_range = subnet.ip_cidr_range
      region     = subnet.region
      private    = var.subnets[name].private
    }
  }
}