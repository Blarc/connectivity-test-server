# GitHub Actions

## Create service account for GKE

https://docs.github.com/en/actions/use-cases-and-examples/deploying/deploying-to-google-kubernetes-engine#configuring-a-service-account-and-storing-its-credentials

1. Create a new service account
   ```bash
   gcloud iam service-accounts create github-sa
   ```
2. Retrieve the email address of the service account you just created:
   ```bash
   gcloud iam service-accounts list
   ```
3. Add roles to service account:
   ```bash
   gcloud projects add-iam-policy-binding $GKE_PROJECT \
     --member=serviceAccount:$SA_EMAIL \
     --role=roles/container.admin
   gcloud projects add-iam-policy-binding $GKE_PROJECT \
     --member=serviceAccount:$SA_EMAIL \
     --role=roles/storage.admin
   gcloud projects add-iam-policy-binding $GKE_PROJECT \
     --member=serviceAccount:$SA_EMAIL \
     --role=roles/container.clusterViewer
   ```
4. Download the JSON keyfile for the service account:
   ```bash
   gcloud iam service-accounts keys create key.json --iam-account=$SA_EMAIL
   ```
