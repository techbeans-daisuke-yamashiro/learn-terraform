# URLマップ
resource "google_compute_url_map" "url_map" {
  name            = "urlmap-${var.dns_zone_name}"
  default_service = google_compute_backend_bucket.backend.self_link
}

# Target HTTPS Proxy
resource "google_compute_target_https_proxy" "https_proxy" {
  name             = "httpsproxy-${var.dns_zone_name}"
  url_map          = google_compute_url_map.url_map.self_link
  ssl_certificates = [google_compute_managed_ssl_certificate.cert.self_link]
}

# IPアドレス確保
resource "google_compute_global_address" "ip_address" {
  name = "ip-${var.dns_zone_name}"
}
# 確保したIPアドレスをアタッチしたGlobal Forwarding Rule (HTTPS)を作成
resource "google_compute_global_forwarding_rule" "https_forwarding_rule" {
  name                            = "fwdrule-https-${var.dns_zone_name}"
  target                          = google_compute_target_https_proxy.https_proxy.self_link
  port_range                      = "443"
  ip_address                      = google_compute_global_address.ip_address.address
  load_balancing_scheme           = "EXTERNAL"
  ip_protocol                     = "TCP"
}

# Cloud DNSにAレコード作成
resource "google_dns_record_set" "a_record" {
  name         = "${var.domain_name}."
  type         = "A"
  ttl          = 300
  managed_zone = var.dns_zone_name

  rrdatas = [
    google_compute_global_address.ip_address.address
  ]
}