terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.77.0"
    }
  }
}

provider "google" {
  credentials = file("howlight-398ab17777d1.json")

  project = "howlight"
  region  = var.region
  zone    = var.zone
}


resource "google_compute_instance" "client" {
  count        = var.client_count
  name         = "${var.name}-client-${count.index}"
  machine_type = var.client_machine_type
  zone         = "${var.region}-${var.zone}"
  tags         = ["client", "auto-join"]

  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.client_disk_size_gb
    }
  }
  network_interface {
    network = "default"
    access_config {

    }
  }
  service_account {
    # https://developers.google.com/identity/protocols/googlescopes
    scopes = [
      "https://www.googleapis.com/auth/compute.readonly",
    ]
  }
  metadata = {
    ssh-keys = "root:$(file(C:/Users/kissi/IdeaProjects/GCP/pub))"
  }
}