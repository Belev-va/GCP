#GCP Instance module

resource "google_compute_instance" "instance" {
  count        = var.instance_count
  name         = "${var.instance_name}-node-${count.index}"
  machine_type = var.instance_type
  zone         = "${var.region}-${var.zone}"
  tags         = ["client", "auto-join", "app", "http-server", "https-server"]

  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.disk_size
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

}






