variable "projectId" {
  type = string
}

variable "region" {
  description = "The region for the GKE cluster"
  type        = string
}

variable "env" {
  description = "Environment"
  type        = string
}
