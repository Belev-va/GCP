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
/*resource "google_compute_project_metadata" "default" {
  metadata = {
    ssh-keys = "belev_job:${file("root.pub")}"
  }
}*/

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
    access_config {}
  }


  metadata = {
    ssh-keys = "howlight:${file("root.pub")}"
    enable-oslogin : "FALSE"
  }
  /*service_account {
    email   = var.service_account_email
    scopes  = var.service_account_scopes
  }*/
}
