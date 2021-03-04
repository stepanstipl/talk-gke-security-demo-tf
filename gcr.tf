resource "google_container_registry" "registry" {
  project  = var.project
  location = "EU"
}

resource "google_storage_bucket_iam_member" "gke-viewer" {
  bucket = google_container_registry.registry.id
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${google_service_account.gke.email}"
}
