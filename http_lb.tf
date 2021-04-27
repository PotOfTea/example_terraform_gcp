resource "google_compute_health_check" "healthcheck" {
  project = google_project.project.name
  name = "${var.name}-healthcheck"
  timeout_sec = 1
  check_interval_sec = 1
  http_health_check {
    port = 80
  }
}

resource "google_compute_instance_group" "web_private_group" {
  project = google_project.project.name
  name = "${var.name}-vm-group"
  description = "Web servers instance group"
  zone = var.gcp_zone
  instances = []
  named_port {
    name = "http"
    port = "80"
  }
}

resource "google_compute_backend_service" "backend_service" {
  project = google_project.project.name
  name = "${var.name}-backend-service"
  port_name = "http"
  protocol = "HTTP"
  health_checks = [google_compute_health_check.healthcheck.self_link]
  backend {
    group = google_compute_instance_group.web_private_group.self_link
    balancing_mode = "RATE"
    max_rate_per_instance = 100
  }
}


resource "google_compute_url_map" "url_map" {
  project = google_project.project.name
  name            = "${var.name}-urlmap"
  default_service = google_compute_backend_service.backend_service.id
}

resource "google_compute_target_http_proxy" "http" {
  project = var.project
  name    = "${var.name}-http-proxy"
  url_map = google_compute_url_map.url_map.self_link
}

resource "google_compute_global_forwarding_rule" "http" {
  project = google_project.project.name
  provider   = google-beta
  name       = "${var.name}-http-rule"
  target     = google_compute_target_http_proxy.http.self_link
  port_range = "80"

}