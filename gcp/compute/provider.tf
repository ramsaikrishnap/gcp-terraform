terraform {
  required_providers {
    google = {
        source = "hashicorp/google"
        version = "latest"
    }
  }
}

provider "google" {
credentials = file("/path/to/your/service-account-key.json")
}