variable "billing_account" {
  type = string
  default = "01489C-791A26-23CEC5"
}

variable "gcp_zone" {
  type = string
  default = "europe-central2-a"
}

variable "gcp_region" {
  type = string
  default = "europe-central2"
}

variable "project" {
  type = string
  default = "rs-test-project"
}

variable "name" {
  type = string
  default = "res-testing"
}

variable "activate_apis" {
  type    = list(string)
  default = ["compute.googleapis.com"]
}