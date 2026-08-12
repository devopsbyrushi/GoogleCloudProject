resource "google_container_node_pool" "gke_nodes" {
  name     = var.node_pool_name
  location = var.zone
  cluster  = google_container_cluster.gke.name

  initial_node_count = var.node_count

  node_config {
    machine_type = var.machine_type

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  depends_on = [
    google_container_cluster.gke
  ]
}
