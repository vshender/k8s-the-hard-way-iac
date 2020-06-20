# Virtual Private Cloud Network

resource "google_compute_network" "kubernetes_network" {
  name = "kubernetes-the-hard-way"

  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "kubernetes_subnetwork" {
  name = "kubernetes"

  network       = google_compute_network.kubernetes_network.id
  ip_cidr_range = "10.240.0.0/24"
}


# Firewall Rules

resource "google_compute_firewall" "kubernetes_firewall_internal" {
  name = "kubernetes-the-hard-way-allow-internal"

  network = google_compute_network.kubernetes_network.id

  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "udp"
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = [
    "10.240.0.0/24",
    "10.200.0.0/16",
  ]
}

resource "google_compute_firewall" "kubernetes_firewall_external" {
  name = "kubernetes-the-hard-way-allow-external"

  network = google_compute_network.kubernetes_network.id

  allow {
    protocol = "tcp"
    ports    = ["22", "6443"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = [
    "0.0.0.0/0",
  ]
}


# Kubernetes Public IP Address

resource "google_compute_address" "kubernetes_ip" {
  name = "kubernetes-the-hard-way"
}
