# This creates a new artifact registry repository for Docker images
# https://console.cloud.google.com/artifacts
# Source: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/artifact_registry_repository

resource "google_artifact_registry_repository" "cts-registry" {
  location      = var.region
  repository_id = "cts-registry"
  description   = "Repository for connection test server project."
  format        = "DOCKER"

  docker_config {
    immutable_tags = false
  }

  lifecycle {
    prevent_destroy = true
  }
}

output "registry-id" {
  value = google_artifact_registry_repository.cts-registry.id
}
