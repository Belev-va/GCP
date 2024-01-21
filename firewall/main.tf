
# Default security group
resource "google_compute_firewall" "default" {
  name    = var.name
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["8080", "8000", "8888", "9990", "5432"]
  }

  target_tags = ["app"]
  source_tags = ["app"]
}

/*
resource "google_compute_firewall" "samba" {
  name    = "samba-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["20","21", "25", "53", "80","110","139","143","443","445","465","587","993","995","53835"]
  }

  target_tags = ["samba"]

  source_tags = ["smb"]
}
*/
