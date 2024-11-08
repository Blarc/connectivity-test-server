resource "google_compute_network" "cts-network" {
  name = "cts-network"

  auto_create_subnetworks  = false
  enable_ula_internal_ipv6 = true
}

resource "google_compute_subnetwork" "cts-subnetwork" {
  name = "cts-subnetwork"

  ip_cidr_range = "10.0.0.0/16"
  region        = var.region

  stack_type       = "IPV4_IPV6"
  ipv6_access_type = "EXTERNAL"

  network = google_compute_network.cts-network.id

  secondary_ip_range {
    range_name    = "services-range"
    ip_cidr_range = "192.168.0.0/24"
  }

  secondary_ip_range {
    range_name    = "pod-ranges"
    ip_cidr_range = "192.168.1.0/24"
  }
}

resource "google_container_cluster" "autopilot-cluster" {
  name = "autopilot-cluster"

  location                 = var.region
  enable_autopilot         = true
  # enable Layer 4 Internal Load Balancer (ILB) subsetting for Google Kubernetes Engine (GKE) clusters
  enable_l4_ilb_subsetting = true

  network    = google_compute_network.cts-network.id
  subnetwork = google_compute_subnetwork.cts-subnetwork.id

  ip_allocation_policy {
    stack_type                    = "IPV4_IPV6"
    services_secondary_range_name = google_compute_subnetwork.cts-subnetwork.secondary_ip_range[0].range_name
    cluster_secondary_range_name  = google_compute_subnetwork.cts-subnetwork.secondary_ip_range[1].range_name
  }

  # Set `deletion_protection` to `true` will ensure that one cannot
  # accidentally delete this instance by use of Terraform.
  deletion_protection = false
}
