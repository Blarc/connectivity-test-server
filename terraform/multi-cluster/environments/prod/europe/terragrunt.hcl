include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/gke-cluster"
}

inputs = {
  region       = "europe-west1"
  env          = "prod"
}

dependencies {
  paths = [ "../../../common" ]
}
