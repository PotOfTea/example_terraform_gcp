resource "google_compute_network" "vpc" {
  name                    = "${var.name}-vpc"
  project                 = google.project.name
  auto_create_subnetworks = true
}
