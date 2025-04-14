# SSL証明書（マネージド）
resource "google_compute_managed_ssl_certificate" "cert" {
  name = "cert-${var.dns_zone_name}"

  managed {
    domains = [var.domain_name]
  }
}
