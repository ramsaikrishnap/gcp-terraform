resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnets" {
  for_each      = var.subnets
  name          = each.key
  ip_cidr_range = each.value.cidr_range
  region        = each.value.region
  network       = google_compute_network.vpc.id

  private_ip_google_access = each.value.private
}

resource "google_compute_router" "router" {
  for_each = {
    for name, subnet in var.subnets : name => subnet
    if subnet.private == false
  }
  name    = "router-${each.key}"
  region  = each.value.region
  network = google_compute_network.vpc.id
}

resource "google_compute_router_nat" "nat" {
  for_each                           = google_compute_router.router
  name                               = "nat-${each.key}"
  router                             = each.value.name
  region                             = each.value.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}