provider "google" {
  version = "1.9.0"
  project = "inductive-actor-198011"
  region  = "europe-west2-a"
}

resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "g1-small"
  zone         = "europe-west2-a"

  boot_disk {
    initialize_params {
      image = "reddit-base"
    }
  }

  metadata {
    ssh-keys = "appuser:${file("~/.ssh/appuser.pub")}"
  }

  network_interface {
    network       = "default"
    access_config = {}
  }
}

resource "google_compute_firewall" "firewall_puma" {
  name = "allow-puma-default"

  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["reddit-app"]
}
