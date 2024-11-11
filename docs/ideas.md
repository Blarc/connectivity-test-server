# Ideas

Here are listed some ideas how to improve the project.

## Create a global load balancer

Terraform files for creating multiple clusters are prepared in [terraform/multi-cluster](../terraform/multi-cluster),
but load balancing is missing. The Google
Cloud [documentation](https://cloud.google.com/load-balancing/docs/choosing-load-balancer#global-regional) describes a
global load balancer that can be distributed globally or span multiple regions, so this shouldn't be too hard and can
probably be automated with
a [Terraform provider](https://registry.terraform.io/modules/gruntwork-io/load-balancer/google/0.2.0/submodules/http-load-balancer).

## Managing deployments over multiple clusters

Since kubernetes doesn't offer a solution for managing deployments over multiple clusters, we need to use an external
tool. ChatGPT suggests Anthos Config Management (ACM) or Google Config Controller. It also mentions multi-cluster
services for cross-cluster load balancing and Anthod Service Mesh for cross-cluster communication. Global load balancing
is definitely needed for such project but cross-cluster communication between the services might not be needed. Another
alternative for config management is also Argo CD which I am more familiar with and would definitely be more interested
to explore.

## Manage Terraform state remotely

By default, terraform saves the current state of the deployed components locally. This can be quite annoying to deal
with, especially if you're working in team with multiple developers. One solution that terraform offers is state
management via S3 backend. This would definetely be interesting to explore and set up, if we'd decide to continue to use
Terraform as our automation tool.

## Replace Terraform with Crossplane

An interesting and more cloud-native approach to managing the state of the deployed componentes on GKE
offers [Crossplane](https://www.crossplane.io/). Although I don't have any experience with it, it would be very
interesting to explore this option, because it uses the Kubernetes API to manage the componentes, which I am much more
familiar with than Terraform.

## Use devbox in GitHub actions

Devbox creates isolated, reproducible development environment and can also be used in GitHub actions instead of using
predefined actions and installing tools manually. This way we would also remove the need to specify the tools' versions
at multiple places and make management of the project easier.
