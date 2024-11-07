# Terraform
https://cloud.google.com/kubernetes-engine/docs/quickstarts/create-cluster-using-terraform

## Authenticate with Google Cloud

1. To authenticate with gcloud CLI run the following command:
   ```bash
   gcloud auth application-default login
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
