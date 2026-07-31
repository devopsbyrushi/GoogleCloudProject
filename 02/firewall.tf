resource "google_compute_firewall" "bankingproject2026_firewall" {

  name = "${var.project_name}-firewall"

  network = google_compute_network.bankingproject2026_vpc.name

  allow {

    protocol = "tcp"

    ports = [

      "22",
      "80",
      "443",
      "8080",
      "8081",
      "9000",
      "3000",
      "9090"

    ]

  }

  source_ranges = ["0.0.0.0/0"]

  target_tags = [
    var.project_name
  ]

}