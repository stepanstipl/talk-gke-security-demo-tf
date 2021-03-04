resource "google_compute_network" "primary" {
  provider = google-beta
  project  = var.project

  name                    = "${local.prefix}-primary"
  auto_create_subnetworks = false

  depends_on = [google_project_service.all]
}

resource "google_compute_subnetwork" "primary" {
  project = var.project

  name                     = "${local.prefix}-primary"
  region                   = var.primary_region
  network                  = google_compute_network.primary.self_link
  ip_cidr_range            = "10.0.0.0/16"
  private_ip_google_access = true
}

resource "google_compute_firewall" "allow-ssh" {
  project = var.project
  name    = "${local.prefix}-allow-ssh"

  network   = google_compute_network.primary.self_link
  direction = "INGRESS"
  priority  = 1000

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = [
    "35.235.240.0/20",
  ]
}
