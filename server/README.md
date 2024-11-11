# Connectivity test server

The server is written in Go, and it responds only on path `/ping` with response `pong`.

## Prerequisites

The devbox shell contains all tools that you need to build the project. If you don't want to use devbox, you will need
the following tools:

- go 1.22.7
- Docker engine (devbox contains podman@5.2.3)
- kubectl@1.31.2
- kustomize@5.5.0

## Build, test and run

1. Move to server directory
   ```bash
   cd server
   ```
2. Build the app:
   ```bash
   go build
   ```
3. Run tests:
   ```bash
   go test
   ```
4. For running locally you have two options:
    1. run the built binary:
       ```bash
       ./connectivity-test-server
       ```
    2. run with go:
       ```bash
       go run main.go
       ```

## Build docker image

1. Move to server directory
   ```bash
   cd server
   ```
2. Build the app:
   ```bash
   # replace with your docker engine
   podman build . -t ${REGION}-docker.pkg.dev/${PROJECT_ID}/cts-registry/connectivity-test-server:local
   ```

## Push to Google Cloud container registry
https://cloud.google.com/artifact-registry/docs/docker/store-docker-container-images

1. Authenticate with the registry (default value for variable `$REGION` set in terraform variables is `europe-west1`)
   ```bash
   gcloud auth configure-docker ${REGION}-docker.pkg.dev
   ```
   This will add a new entry to your `.docker/config.json`.
2. Push to the registry:
   ```bash
   docker push ${REGION}-docker.pkg.dev/${PROJECT_ID}/cts-registry/connectivity-test-server:local

## Deploy

### Connect to GKE cluster

1. Login to gcloud:
   ```bash
   gcloud auth login
   ```
2. Run the following command to automatically add a new entry to your `kubeconfig` (default value for variable `$REGION`
   set in terraform variables is `europe-west1`):
   ```bash
   gcloud container clusters get-credentials autopilot-cluster --region $REGION --project $PROJECT_ID
   ```

### Deploy the server
1. Move to k8s directory
   ```bash
   cd server/k8s
   ```
2. Build the app:
   ```bash
   # set the image tag to the one you built
   kustomize edit set image "${REGION}-docker.pkg.dev/${PROJECT_ID}/cts-registry/connectivity-test-server:local"
   # OPTIONAL: use the image from GitHub registry
   kustomize edit set image ghcr.io/blarc/connectivity-test-server:latest
   # apply the configuration
   kustomize build . -f | kubectl apply -f -
   ```
