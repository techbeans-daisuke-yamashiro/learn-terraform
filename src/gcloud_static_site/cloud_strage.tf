# Storage Bucket
resource "google_storage_bucket" "static_site" {
  name                        = var.domain_name
  location                    = "US"
  uniform_bucket_level_access = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }

  cors {
    origin          = ["*"]
    method          = ["GET", "HEAD", "OPTIONS"]
    response_header = ["Content-Type"]
    max_age_seconds = 3600
  }
}

# Bucketを公開
resource "google_storage_bucket_iam_binding" "public_access" {
  bucket = google_storage_bucket.static_site.name
  role   = "roles/storage.objectViewer"

  members = [
    "allUsers",
  ]
}


# Backend Bucket
resource "google_compute_backend_bucket" "backend" {
  name        = "backend-${var.dns_zone_name}"
  bucket_name = google_storage_bucket.static_site.name
  enable_cdn  = true
}