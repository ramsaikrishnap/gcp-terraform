variable "credentials"{
    type =file
}
variable "project_id"{
    type = string
    default = "your-porject-id"
}
variable "compute_instance_name"{
    type = string
    default = "your_compute_instance_name"
}
variable "machine_type"{
    type= string
    default = "your_machine_type"
}
variable "zone" {
  type = string
  default = "us-east1-a"
}
variable "subnet_name" {
  type = string
  default = "my-subnet"
}
variable "subnet_region" {
  type = string
  default = "us-east1"
}
variable "root_disk_type" {
  type =string
  default = "n2-standard-2"
}
variable "root_disk_size" {
  type = number
  default = 100
}
variable "compute_image_name" {
  type = string
  default = "my-image"
}
variable "additional_disks" {
  type = list(number)
  default = [ 50,50 ]
}
variable "additional_disk_type" {
  type= string
  default = "standard"
}
variable "kms_key_name" {
  type = string
  default = "my-kms-key"
}
variable "kms_key_self_link" {
  type = string
  default = null
}
variable "startup_script_path" {
  description = "Path to the startup script"
  type        = string
  default     = "/path/to/your_startup_script.sh"
}