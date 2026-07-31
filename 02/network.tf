resource "google_compute_network" "bankingproject2026_vpc" {

  name = var.network_name

  auto_create_subnetworks = false

}

resource "google_compute_subnetwork" "bankingproject2026_subnet" {

  name          = var.subnet_name
  ip_cidr_range = var.subnet_cidr

  region = var.region

  network = google_compute_network.bankingproject2026_vpc.id

}