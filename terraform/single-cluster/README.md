# Single cluster

This folder contains terraform file to create a single k8s cluster with Google GKE.

## Prerequisites

The devbox shell contains all tools that you need to create cluster. If you don't want to use devbox, you will need the
following tools:

- gcloud@latest
- terraform@1.9.8

You will also need a valid project on Google cloud with billing.

## Create clusters

1. To authenticate with gcloud CLI run the following command:
   ```bash
   gcloud auth login
   ```
2. Make sure you're using the correct project, by listing the projects:
   ```bash
   gcloud projects list
   ```
   and setting the one you'd like to use:
   ```bash
   gcloud config set project $PROJECT_ID
   ```
3. Initialize terraform:
   ```bash
   terragrunt init
   ```
4. Plan the creation of cluster:
   ```bash
   terragrunt run-all plan
   ```
5. Create cluster with terragrunt:
   ```bash
   terragrunt run-all apply
   ```

## Destroy the cluster
https://cloud.google.com/kubernetes-engine/docs/quickstarts/create-cluster-using-terraform#clean-up
1. Run the following command:
   ```bash
   terraform destroy --auto-approve
   ```

## Connecting to the cluster

1. Login to gcloud:
   ```bash
   gcloud auth login
   ```
2. Run the following command to automatically add a new entry to your `kubeconfig` (default value for variable `$REGION`
   set in terraform variables is `europe-west1`):
   ```bash
   gcloud container clusters get-credentials autopilot-cluster --region $REGION --project $PROJECT_ID
   ```

## Pushing to Google Cloud container registry

https://cloud.google.com/artifact-registry/docs/docker/store-docker-container-images

1. Authenticate with the registry (default value for variable `$REGION` set in terraform variables is `europe-west1`)
   ```bash
   gcloud auth configure-docker $REGION-docker.pkg.dev
   ```
   This will add a new entry to your `.docker/config.json`.
2. Push to the registry:
   ```bash
   docker push europe-west1-docker.pkg.dev/$PROJECT_ID/cts-registry/connectivity-test-server:test1
