data "google_project" "project"{
  project_id = var.project_id
}

data "google_compute_subnetwork" "my_subnet"{
  name = var.subnet_name
  project = var.project_id
  region = var.subnet_region
}
data "google_compute_image" "my_image"{
  name= var.compute_image_name
}

locals {
  labels = {
    project = "my-first-project"
    environment = "test"
  }
}

resource "google_compute_instance" "my_instance" {
  name = var.compute_instance_name
  machine_type = var.machine_type
  zone = var.zone
  boot_disk {
    initialize_params {
      type=var.root_disk_type
      image= data.google_compute_image.my_image.self_link
      size = var.root_disk_size
    }
  }
  labels =  local.labels
  network_interface {
    subnetwork = data.google_compute_subnetwork.my_subnet.subnetwork
    network = data.google_compute_subnetwork.my_subnet.network
  }
  metadata = {
    size = var.root_disk_size
  }
  metadata_startup_script = file(var.startup_script_path)
  service_account {
    scopes = [ "cloud-platform" ]
  }
}

resource "google_compute_disk" "mydisk" {
  count= length(var.additional_disks)
  name="${var.compute_instance_name}-disk${count.index}"
  type= "pd-${var.additional_disk_type}"
  size = var.additional_disks[count.index]
  zone=var.zone
  disk_encryption_key {
    kms_key_self_link = var.kms_key_self_link
  }
  labels = local.labels
  depends_on = [ google_compute_instance.my_instance ]
}

resource "google_compute_attached_disk" "disk_attach" {
  count=length(var.additional_disks)
  disk= google_compute_disk.mydisk[count.index].id
  instance = var.compute_instance_name
  project = var.project_id
  depends_on = [ google_compute_instance.my_instance] 
}