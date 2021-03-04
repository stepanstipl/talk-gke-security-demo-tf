resource "google_service_account" "gke" {
  project = var.project

  account_id   = "${local.prefix}-gke"
  display_name = "Felix GKE node service account"
}

resource "google_project_iam_member" "gke" {
  for_each = toset(["logging.logWriter",
    "monitoring.metricWriter",
    "monitoring.viewer",
  "stackdriver.resourceMetadata.writer"])
  project = var.project

  role   = "roles/${each.value}"
  member = "serviceAccount:${google_service_account.gke.email}"
}
