resource "google_compute_instance" "db" {
  name                      = "reddit-db"
  machine_type              = "${var.db_machine_type}"
  zone                      = "${var.zone}"
  tags                      = ["reddit-db"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "${var.db_disk_image}"
    }
  }

  network_interface {
    network = "default"

    access_config = {}
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
}

resource "null_resource" "db" {
  count = "${var.deploy ? 1 : 0}"

  connection {
    host        = "${element(google_compute_instance.db.*.network_interface.0.access_config.0.assigned_nat_ip, 0)}"
    type        = "ssh"
    user        = "appuser"
    agent       = false
    private_key = "${file(var.private_key_path)}"
  }

  provisioner "remote-exec" {
    script = "${path.module}/files/mongo-remote.sh"
  }
}
