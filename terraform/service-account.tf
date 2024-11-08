terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.34.0"
    }
  }
}
# This create a service account used by Github Actions.
# source: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account
resource "google_service_account" "github-actions-sa" {
  account_id   = "github-actions"
  display_name = "Github Actions"
  description  = "Service account used by Github Actions."
  project      = var.projectId
  # create_ignore_already_exists = true
}

# source: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account_iam
resource "google_project_iam_member" "github-actions-container-admin" {
  project = var.projectId
  role    = "roles/container.admin"
  member  = "serviceAccount:${google_service_account.github-actions-sa.email}"
}

resource "google_project_iam_member" "github-actions-storage-admin" {
  project = var.projectId
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.github-actions-sa.email}"
}

resource "google_project_iam_member" "github-actions-cluster-viewer" {
  project = var.projectId
  role    = "roles/container.clusterViewer"
  member  = "serviceAccount:${google_service_account.github-actions-sa.email}"
}

resource "google_project_iam_member" "github-actions-registry-writer" {
  project = var.projectId
  // https://cloud.google.com/artifact-registry/docs/access-control#roles
  role    = "roles/artifactregistry.writer"
  member  = "serviceAccount:${google_service_account.github-actions-sa.email}"
}

resource "google_service_account_key" "github-actions-key" {
  service_account_id = google_service_account.github-actions-sa.name
  public_key_type    = "TYPE_RAW_PUBLIC_KEY"
}

# Save the private key to a local file
resource "local_file" "github-actions-key-file" {
  content  = base64decode(google_service_account_key.github-actions-key.private_key)
  filename = "${path.module}/github-actions-key.json"
}

# Output a message guiding users on handling the private key securely
output "private_key_instructions" {
  value = "The private key has been saved to github-actions-key.json. Handle it securely."
}
