resource "google_service_account" "felix" {
  project = var.project

  account_id   = "${local.prefix}-felix"
  display_name = "Felix app service account"
}

resource "google_service_account_iam_member" "felix" {
  service_account_id = google_service_account.felix.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.project}.svc.id.goog[default/felix]"
}

data "google_iam_policy" "felix" {
  binding {
    role = "roles/storage.objectViewer"
    members = [
      "serviceAccount:${google_service_account.felix.email}"
    ]
  }
}

resource "google_storage_bucket_iam_policy" "felix" {
  bucket      = google_storage_bucket.static.name
  policy_data = data.google_iam_policy.felix.policy_data
}
