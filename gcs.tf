resource "google_storage_bucket" "static" {
  project = var.project
  name    = "${var.project}-${local.prefix}-static"

  location                    = "eu"
  uniform_bucket_level_access = true
  force_destroy               = true
}


