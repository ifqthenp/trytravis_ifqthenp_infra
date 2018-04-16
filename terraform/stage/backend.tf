terraform {
  backend "gcs" {
    bucket = "ifqthenp_tfstate_bucket"
    prefix = "terraform/stage"
  }
}
