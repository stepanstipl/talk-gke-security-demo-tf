resource "google_project_service" "all" {
  project = var.project

  for_each = toset([
    "compute.googleapis.com",
    "container.googleapis.com",
    "iamcredentials.googleapis.com",
    "dns.googleapis.com",
    "iap.googleapis.com"
  ])
  service = each.key

  disable_on_destroy = false
}
