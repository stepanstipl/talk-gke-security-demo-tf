resource "google_storage_bucket_object" "images" {
  for_each = fileset("${path.module}/images", "*.jpg")

  name   = "images/${each.key}"
  source = "${path.module}/../images/${each.key}"
  bucket = google_storage_bucket.static.name
}
