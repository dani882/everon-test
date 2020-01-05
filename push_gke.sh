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

# Configured Docker to use gcloud as a credential helper
export PROJECT_ID="$(gcloud config get-value project -q)"
gcloud auth configure-docker

#Pull docker image to Google Container Registry
docker build -t everon-nginx .
docker tag everon-nginx gcr.io/${PROJECT_ID}/everon-nginx
docker push gcr.io/${PROJECT_ID}/everon-nginx

#Create GKE cluster
terraform init && terraform apply -auto-approve



kubectl run everon-nginx --image=gcr.io/original-bolt-264015/everon-nginx --port=8080

# Remove certificates files
rm -rf Modules/docker-container/*.crt Modules/docker-container/*.key

