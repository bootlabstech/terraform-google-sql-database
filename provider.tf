terraform {
  required_version = ">= 1.5.0"

  required_providers {
    google = {
      version = "6.41.0"
      source  = "hashicorp/google"
    }
  }
}