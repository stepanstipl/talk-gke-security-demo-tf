resource "google_container_cluster" "primary" {
  provider = google-beta
  project  = var.project
  name     = "${local.prefix}-primary"

  location = var.primary_region

  workload_identity_config {
    identity_namespace = "${var.project}.svc.id.goog"
  }

  network    = google_compute_network.primary.self_link
  subnetwork = google_compute_subnetwork.primary.self_link
  ip_allocation_policy {}

  release_channel {
    channel = "REGULAR"
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "10.1.0.0/28"
  }

  initial_node_count = 1

  node_config {
    machine_type = "e2-standard-2"
    preemptible  = true

    oauth_scopes = ["cloud-platform"]

    metadata = {
      disable-legacy-endpoints = "true"
    }

    workload_metadata_config {
      node_metadata = "GKE_METADATA_SERVER"
    }

    service_account = google_service_account.gke.email
  }

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }

}
