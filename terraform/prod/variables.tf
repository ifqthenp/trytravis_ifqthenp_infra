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

# variable private_key_path {
#   description = "The contents of an SSH key to use for the connection"
# }

# variable disk_image {
#   description = "Disk image"
# }

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}

variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
}
