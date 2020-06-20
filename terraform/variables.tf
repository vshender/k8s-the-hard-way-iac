variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
  default     = "us-west1"
}

variable zone {
  description = "Zone"
  default     = "us-west1-c"
}

variable machine_type {
  description = "Machine type for compute instances"
  default     = "n1-standard-1"
}

variable disk_image {
  description = "Disk image for compute instances"
  default     = "ubuntu-os-cloud/ubuntu-1804-lts"
}

variable disk_size {
  description = "Disk size for compute instances"
  type        = number
  default     = 200
}

variable controller_count {
  description = "Number of controller instances"
  type        = number
  default     = 3
}

variable worker_count {
  description = "Number of worker instances"
  type        = number
  default     = 3
}

variable user {
  description = "User to create on the instances"
}

variable public_key_path {
  description = "Path to the public key used to connect to instances"
}
