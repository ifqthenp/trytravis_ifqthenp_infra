terraform {
  backend "gcs" {
    bucket = "my_test_10001"
    prefix = "terraform/state"
  }
}
