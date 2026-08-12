# ============================================================
# Existing Network Configuration
# ============================================================
# The VPC and GKE subnet were created in the previous phase.
# We are NOT creating them again.
# Terraform only reads the existing resources.
# ============================================================

data "google_compute_network" "existing_vpc" {
  name = "bankingproject2026-vpc"
}

data "google_compute_subnetwork" "existing_gke_subnet" {
  name   = "bankingproject2026-gke-subnet"
  region = var.region
}
