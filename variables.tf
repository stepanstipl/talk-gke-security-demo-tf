# Resource names will be prefixed with this
# - allows multiple instances in one project
variable "project_prefix" {
  type    = string
  default = "felix"
}

# Project name
variable "project" {
  type    = string
  default = "my-demo-project"
}

# GCP Region
variable "primary_region" {
  type    = string
  default = "europe-west1"
}

# DNS zone
variable "dns_zone" {
  type    = string
  default = "my-dns-zone"
}

locals {
  prefix = var.project_prefix
}
