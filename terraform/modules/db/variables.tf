variable zone {
  description = "The zone that the machine should be created in"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable private_key_path {
  description = "The contents of an SSH key to use for the connection"
}

variable db_disk_image {
  description = "Disk image for reddit db"
}

variable db_machine_type {
  description = "Machine type for db instance"
}

variable deploy {
  description = "If true, reddit application will be deployed to the server"
}
