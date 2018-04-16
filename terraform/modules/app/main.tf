resource "google_compute_instance" "app" {
  name                      = "reddit-app"
  machine_type              = "${var.app_machine_type}"
  zone                      = "${var.zone}"
  tags                      = ["reddit-app"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "${var.app_disk_image}"
    }
  }

  network_interface {
    network = "default"

    access_config = {
      nat_ip = "${google_compute_address.app_ip.address}"
    }
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
}

resource "null_resource" "app" {
  count = "${var.deploy ? 1 : 0}"

  connection {
    host        = "${element(google_compute_instance.app.*.network_interface.0.access_config.0.assigned_nat_ip, 0)}"
    type        = "ssh"
    user        = "appuser"
    agent       = false
    private_key = "${file(var.private_key_path)}"
  }

  provisioner "file" {
    content     = "${data.template_file.puma.rendered}"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "${path.module}/files/install_reddit.sh"
  }
}

resource "google_compute_address" "app_ip" {
  name = "reddit-app-ip"
}

data "template_file" "puma" {
  template = "${file("${path.module}/files/puma.service")}"

  vars = {
    db_address = "${var.db_address}"
  }
}
