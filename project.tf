resource "random_id" "id" {
  byte_length = 4
  prefix      = var.project
}

resource "google_project" "project" {
  name            = var.project
  project_id      = random_id.id.hex
  billing_account = var.billing_account
}

module "project-services" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = "10.1.1"

  project_id = google_project.project.id

  activate_apis = [
    "compute.googleapis.com",
  ]
}