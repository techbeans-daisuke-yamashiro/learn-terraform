# Cloud Load Balancerの作成
resource "google_compute_global_forwarding_rule" "my_lb" {
  name       = "<YOUR_FORWARDING_RULE_NAME>"
  ip_address = "<YOUR_IP_ADDRESS>"
  port_range = "<YOUR_PORT_RANGE>"

  target = google_compute_backend_service.my_backend_service.self_link
}

resource "google_compute_http_health_check" "my_health_check" {
  name                = "<YOUR_HEALTH_CHECK_NAME>"
  check_interval_sec  = var.http_health_check_interval
  timeout_sec         = var.timeout
  healthy_threshold   = var.http_health_check_healthy_threshold
  unhealthy_threshold = var.http_health_check_unhealthy_threshold
  request_path        = "<YOUR_REQUEST_PATH>"
}

resource "google_compute_backend_service" "my_backend_service" {
  name        = "<YOUR_BACKEND_SERVICE_NAME>"
  port_name   = "<YOUR_BACKEND_SERVICE_PORT_NAME>"
  protocol    = "HTTP"
  timeout_sec = var.http_health_check_timeout

  backend {
    group = google_container_cluster.my_cluster.name
  }

  health_checks = [
    google_compute_http_health_check.my_health_check.self_link
  ]
}

resource "google_compute_url_map" "my_url_map" {
  name            = "<YOUR_URL_MAP_NAME>"
  default_service = google_compute_backend_service.my_backend_service.self_link
}

resource "google_compute_ssl_certificate" "my_ssl_certificate" {
  name        = "<YOUR_SSL_CERTIFICATE_NAME>"
  certificate = "<YOUR_SSL_CERTIFICATE_CONTENT>"
  private_key = "<YOUR_SSL_PRIVATE_KEY_CONTENT>"
}

resource "google_compute_target_https_proxy" "my_https_proxy" {
  name             = "<YOUR_HTTPS_PROXY_NAME>"
  url_map          = google_compute_url_map.my_url_map.self_link
  ssl_certificates = [google_compute_ssl_certificate.my_ssl_certificate.self_link]
}

