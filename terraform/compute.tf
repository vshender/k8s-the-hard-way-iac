# Kubernetes Controllers

resource "google_compute_instance" "kubernetes_controller" {
  count = var.controller_count

  name         = "controller-${count.index}"
  machine_type = var.machine_type
  zone         = var.zone

  tags = ["kubernetes-the-hard-way", "controller"]

  boot_disk {
    initialize_params {
      image = var.disk_image
      size  = var.disk_size
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.kubernetes_subnetwork.id
    network_ip = "10.240.0.1${count.index}"
    access_config {}
  }

  can_ip_forward = true

  service_account {
    scopes = [
      "compute-rw",
      "storage-ro",
      "service-management",
      "service-control",
      "logging-write",
      "monitoring",
    ]
  }

  metadata = {
    ssh-keys = "${var.user}:${file(var.public_key_path)}"
  }
}


# Kubernetes Workers

resource "google_compute_instance" "kubernetes_worker" {
  count = var.worker_count

  name         = "worker-${count.index}"
  machine_type = var.machine_type
  zone         = var.zone

  tags = ["kubernetes-the-hard-way", "worker"]

  boot_disk {
    initialize_params {
      image = var.disk_image
      size  = var.disk_size
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.kubernetes_subnetwork.id
    network_ip = "10.240.0.2${count.index}"
    access_config {}
  }

  can_ip_forward = true

  service_account {
    scopes = [
      "compute-rw",
      "storage-ro",
      "service-management",
      "service-control",
      "logging-write",
      "monitoring",
    ]
  }

  metadata = {
    pod-cidr = "10.200.${count.index}.0/24"
    ssh-keys = "${var.user}:${file(var.public_key_path)}"
  }
}
