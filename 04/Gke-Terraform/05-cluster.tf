resource "google_container_cluster" "gke" {
  name     = var.cluster_name
  location = var.zone

  network    = data.google_compute_network.existing_vpc.name
  subnetwork = data.google_compute_subnetwork.existing_gke_subnet.name

  remove_default_node_pool = true
  initial_node_count       = 1

  networking_mode = "VPC_NATIVE"

  ip_allocation_policy {
    cluster_secondary_range_name  = var.pods_secondary_range_name
    services_secondary_range_name = var.services_secondary_range_name
  }

  depends_on = [
    google_project_service.compute,
    google_project_service.container
  ]
}
