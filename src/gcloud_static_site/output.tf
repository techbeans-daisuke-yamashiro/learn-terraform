output "bucket_name" {
  value = google_storage_bucket.static_site.name
}

output "site_url" {
  value = "https://${var.domain_name}"
}

output "load_balancer_ip" {
  value = google_compute_global_address.ip_address.address
}
