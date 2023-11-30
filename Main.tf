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

  project = "howlightuniversity-000001"
  region  = var.region
  zone    = var.zone
}
/*resource "google_compute_project_metadata" "default" {
  metadata = {
    ssh-keys = "belev_job:${file("root.pub")}"
  }
}*/

resource "google_compute_firewall" "default" {
  name    = "test-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["8080", "8000", "8888", "9990", "5432"]
  }

  target_tags = ["app"]
}

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

resource "google_compute_instance" "client" {
  count        = var.client_count
  name         = "${var.name}-client-${count.index}"
  machine_type = var.client_machine_type
  zone         = "${var.region}-${var.zone}"
  tags         = ["client", "auto-join", "app","samba", "http-server", "https-server"]

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
    ssh-keys = "howlight:${file("root3.pub")}"
    enable-oslogin : "FALSE"
  }


  /*service_account {
    email   = var.service_account_email
    scopes  = var.service_account_scopes
  }*/
}
resource "google_compute_instance" "server" {
  count        = var.server_count
  name         = "${var.name}-server-${count.index}"
  machine_type = var.server_machine_type
  zone         = "${var.region}-${var.zone}"
  tags         = ["client", "auto-join", "app", "http-server", "https-server"]

  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.server_disk_size_gb
    }
  }
  network_interface {
    network = "default"
    access_config {}
  }
  metadata = {
    ssh-keys = "howlight:${file("root3.pub")}"
    enable-oslogin : "FALSE"
  }
}

resource "google_compute_instance" "jenkins" {
  count        = 1
  name         = "${var.name}-jenkins-${count.index}"
  machine_type = var.client_machine_type
  zone         = "${var.region}-${var.zone}"
  tags         = ["client", "auto-join", "app", "http-server", "https-server"]

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
    #"ssh-keys" = <<EOT
        #"howlight:${file("root.pub")}"
        #"howlight:${file("root2.pub")}"
    #EOT
    ssh-keys = "howlight:${file("root.pub")}"

    enable-oslogin : "FALSE"
  }
 # tags = [
  #  "${lower(var.name)}",
  #  "${lower(var.environment)}",
   # "${lower(var.orchestration)}"
  #]
}

resource "google_compute_instance" "samba" {

  name         = "${var.name}-samba"
  machine_type = var.client_machine_type
  zone         = "${var.region}-${var.zone}"
  tags         = ["client", "auto-join", "samba", "http-server", "https-server"]

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
    #"ssh-keys" = <<EOT
    #"howlight:${file("root.pub")}"
    #"howlight:${file("root2.pub")}"
    #EOT
    ssh-keys = "howlight:${file("root.pub")}"

    enable-oslogin : "FALSE"
  }
  # tags = [
  #  "${lower(var.name)}",
  #  "${lower(var.environment)}",
  # "${lower(var.orchestration)}"
  #]

connection {
  type        = "ssh"
  user        = "howlight"
  private_key = file("id_rsa")
  host        = self.network_interface[0].access_config[0].nat_ip


}
provisioner "remote-exec" {
  inline = [
    "sudo yum update -y",
    "sudo yum install chrony -y",
    "sudo systemctl enable chrony",
    "sudo systemctl start chrony",
    "sudo timedatectl set-timezone Europe/Brussels",
    "sudo yum install wget -y",
    "sudo yum install nano -y"
    #"sudo yum install squid -y",
    #"sudo systemctl start squid",
    #"sudo yum -y install epel-release;yum -y install python34-devel.x86_64",
    #"sudo yum install samba-dc -y",
    #"sudo cp /etc/samba/smb.conf /etc/samba/smb.conf_orig",
    #"sudo mkdir -p /samba/anonymous_shared_directory",
    #"sudo chmod -R 0775 /samba/anonymous_shared_directory",
    #"sudo chown -R nobody:nobody /samba/anonymous_shared_directory",
    #"sudo chcon -t samba_share_t /samba/anonymous_shared_directory",
    #"sudo wget https://raw.githubusercontent.com/Belev-va/yc/main/config",
    #"sudo cp -f config /etc/selinux/config",
    #"sudo wget https://raw.githubusercontent.com/Belev-va/yc/main/smb.conf",
    #"sudo cp -f smb.conf /etc/samba/smb.conf",
    #"sudo systemctl start smb.service",
    #"sudo systemctl start nmb.service"
  ]
}
}