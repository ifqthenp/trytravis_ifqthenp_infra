provider "google" {
  version = "1.9.0"
  project = "${var.project}"
  region  = "${var.region}"
}
