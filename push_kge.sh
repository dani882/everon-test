#!/bin/bash

#####################################
##### Deploy GCR image to GKE Cluster
#####################################

cluster_name="everon-cluster"


#Ensure the required APIs are enabled:
gcloud services enable storage-api.googleapis.com
gcloud services enable cloudresourcemanager.googleapis.com
gcloud services enable compute.googleapis.com
gcloud services enable container.googleapis.com
gcloud services enable iam.googleapis.com

#Create GKE cluster
terraform init && terraform apply -auto-approve

# Configured Docker to use gcloud as a credential helper
gcloud auth configure-docker


# Remove certificates files
rm -rf Modules/docker-container/*.crt Modules/docker-container/*.key

