terraform {
    required_version = ">= 0.15"

    required_providers {
        google = {
            source  = "hashicorp/google"
            version = "~> 3.65.0"
        }
        google-beta = {
            source  = "hashicorp/google-beta"
            version = "~> 3.65.0"
        }
    }
}

provider "google" {}

provider "google-beta" {}