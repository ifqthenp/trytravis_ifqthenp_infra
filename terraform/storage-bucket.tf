provider "google" {
  version = "1.9.0"
  project = "${var.project}"
  region  = "${var.region}"
}

module "storage-bucket" {
  force_destroy = true
  source        = "SweetOps/storage-bucket/google"
  version       = "0.1.1"

  name = ["ifqthenp_tfstate_bucket", "my_test_10002"]
}

output storage-bucket_url {
  value = "${module.storage-bucket.url}"
}
