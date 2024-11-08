# Terraform
https://cloud.google.com/kubernetes-engine/docs/quickstarts/create-cluster-using-terraform

## Google Cloud

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
3. To create a GKE cluster, you need to enable API `container.googleapis.com`, you can do this by running the following command:
   ```bash
   gcloud services enable container.googleapis.com
   ```
### Google Cloud Container Registry
**Deprecated**: This is automated with terraform.
1. To use the Google cloud container registry, you need to enable API `artifactregistry.googleapis.com`:
   ```bash
   gcloud services enable artifactregistry.googleapis.com
   ```
2. Create a container registry repository:
   ```bash
    gcloud artifacts repositories create cts-registry \
      --repository-format=docker \
      --location=europe-west1 \
      --description="Container registry for connectivity test server."
   ```
### Pushing to Google Cloud container registry
https://cloud.google.com/artifact-registry/docs/docker/store-docker-container-images
1. Authenticate with the registry:
   ```bash
   gcloud auth configure-docker europe-west1-docker.pkg.dev
   ```
   This will add a new entry to your `.docker/config.json`.
2. Push to the registry:
   ```bash
   docker push europe-west1-docker.pkg.dev/$PROJECT_ID/cts-registry/connectivity-test-server:test1
   ```

## Create autopilot GKE cluster

1. Update variables values in `variables.tf`.
2. Run the following command to see what is going to be done:
   ```bash
   terraform plan
   ```
3. Run the following command to apply:
   ```bash
   terraform apply
   ```

## Connecting to the cluster

1. Login to gcloud:
   ```bash
   gcloud auth login
   ```
2. Run the following command to automatically add a new entry to your `kubeconfig`:
   ```bash
   gcloud container clusters get-credentials autopilot-cluster --region europe-west1 --project connectivity-test-server
   ```

## Destroy the cluster
https://cloud.google.com/kubernetes-engine/docs/quickstarts/create-cluster-using-terraform#clean-up
1. Run the following command:
   ```bash
   terraform destroy --auto-approve
   ```
