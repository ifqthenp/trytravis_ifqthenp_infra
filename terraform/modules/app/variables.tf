variable zone {
  description = "The zone that the machine should be created in"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable private_key_path {
  description = "Path to the private key used for ssh access"
}

variable app_disk_image {
  description = "Disk image for reddit app"
}

variable app_machine_type {
  description = "Machine type for app instance"
}

variable db_address {
  description = "Address of db server"
}

variable deploy {
  description = "If true, reddit application will be deployed to the server"
}
