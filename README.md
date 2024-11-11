# Connectivity test server

A simple connectivity test backend server deployed on GKE cluster using Terraform.

## Features

- easy setup of GKE cluster using Terraform
- a very small container image for deploying a simple connectivity test server
- CI/CD with GitHub actions that builds and tests the server, builds the container image, pushes the image to GitHub and
  Google Cloud registry and deploys the built image to GKE cluster
- Kubernetes configuration of a deployment with anti-affinity rules and horizontal pod autoscaler which achieves high
  availability and resilience to failures

## Todo
- create a global load balancer for multiple clusters in different regions
- figure out how to manage deployments over multiple clusters
- manage Terraform state with remote S3
- use [Crossplane](https://www.crossplane.io/) instead of Terraform
- use devbox in GitHub Actions

More detailed ideas about these points can be found in [docs/ideas.md](docs/ideas.md).

## Setting up the environment

1. Install [devbox](https://www.jetify.com/devbox) by following the
   documentation [here](https://www.jetify.com/docs/devbox/installing_devbox/?install-method=linux).
2. Run command `devbox shell`.

## How tos
- for creating a new GKE cluster using Terraform check [terraform/README.md](terraform/README.md)
- for building, testing, building container image and deploying the server check [server/README.md](server/README.md)
- for running a load test check [server/k8s/README.md](server/k8s/README.md#load-test)
