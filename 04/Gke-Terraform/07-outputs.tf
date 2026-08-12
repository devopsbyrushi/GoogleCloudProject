output "gke_cluster_name" {
  description = "GKE cluster name"
  value       = google_container_cluster.gke.name
}

output "gke_cluster_location" {
  description = "GKE cluster location"
  value       = google_container_cluster.gke.location
}

output "gke_cluster_endpoint" {
  description = "GKE cluster endpoint"
  value       = google_container_cluster.gke.endpoint
  sensitive   = true
}

output "gke_node_pool_name" {
  description = "GKE node pool name"
  value       = google_container_node_pool.gke_nodes.name
}

output "gke_node_count" {
  description = "Number of GKE worker nodes"
  value       = var.node_count
}

output "gke_machine_type" {
  description = "GKE worker machine type"
  value       = var.machine_type
}

output "gke_vpc_name" {
  description = "Existing VPC used by GKE"
  value       = data.google_compute_network.existing_vpc.name
}

output "gke_subnet_name" {
  description = "Existing subnet used by GKE"
  value       = data.google_compute_subnetwork.existing_gke_subnet.name
}
