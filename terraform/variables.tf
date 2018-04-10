variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
  default     = "europe-west2"
}

variable zone {
  description = "The zone that the machine should be created in"
  default     = "europe-west2-a"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable disk_image {
  description = "Disk image"
}
