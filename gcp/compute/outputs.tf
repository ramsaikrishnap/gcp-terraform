output "instance_ip_address" {
  description = "The internal IP address of the instance"
  value       = google_compute_instance.my_instance.network_interface[0].network_ip
}

output "instance_external_ip" {
  description = "The external IP address of the instance (if applicable)"
  value       = google_compute_instance.my_instance.network_interface[0].access_config[0].nat_ip
}

output "additional_disk_names" {
  description = "The names of the additional disks"
  value       = google_compute_disk.mydisk[*].name
}
