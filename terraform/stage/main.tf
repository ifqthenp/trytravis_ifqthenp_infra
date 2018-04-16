provider "google" {
  version = "1.9.0"
  project = "${var.project}"
  region  = "${var.region}"
}

module "app" {
  source           = "../modules/app"
  public_key_path  = "${var.public_key_path}"
  private_key_path = "${var.private_key_path}"
  zone             = "${var.zone}"
  app_disk_image   = "${var.app_disk_image}"
  app_machine_type = "${var.app_machine_type}"
  db_address       = "${module.db.db_internal_ip}"
  deploy           = "${var.deploy}"
}

module "db" {
  source           = "../modules/db"
  public_key_path  = "${var.public_key_path}"
  private_key_path = "${var.private_key_path}"
  zone             = "${var.zone}"
  db_disk_image    = "${var.db_disk_image}"
  db_machine_type  = "${var.db_machine_type}"
  deploy           = "${var.deploy}"
}

module "vpc" {
  source = "../modules/vpc"
}
