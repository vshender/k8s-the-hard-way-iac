output "kubernetes_ip" {
  value = google_compute_address.kubernetes_ip.address
}

output "kubernetes_controller_ips" {
  value = google_compute_instance.kubernetes_controller[*].network_interface[0].access_config[0].nat_ip
}

output "kubernetes_worker_ips" {
  value = google_compute_instance.kubernetes_worker[*].network_interface[0].access_config[0].nat_ip
}
