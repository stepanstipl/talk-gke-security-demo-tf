data "google_dns_managed_zone" "primary" {
  project = var.project
  name    = var.dns_zone
}

resource "google_compute_global_address" "primary" {
  project = var.project
  name    = "${local.prefix}-primary"
}

resource "google_dns_record_set" "primary" {
  project = var.project

  name = "${local.prefix}.${data.google_dns_managed_zone.primary.dns_name}"
  type = "A"
  ttl  = 60

  managed_zone = data.google_dns_managed_zone.primary.name
  rrdatas      = [google_compute_global_address.primary.address]
}
