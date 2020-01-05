#!/bin/bash

#####################################
####### Create GKE Cluster ##########
#####################################


#Ensure the required APIs are enabled:
gcloud services enable storage-api.googleapis.com
gcloud services enable cloudresourcemanager.googleapis.com
gcloud services enable compute.googleapis.com
gcloud services enable container.googleapis.com
gcloud services enable iam.googleapis.com

# #Push docker image to DockerHub
# docker build -t everon-nginx .
# docker tag everon-nginx jrdevers/everon-nginx
# docker push jrdevers/everon-nginx

# Start GKE cluster infrastructure
terraform init && terraform apply -auto-approve

# # Remove certificates files
# rm -rf Modules/docker-container/files/*.crt Modules/docker-container/files/*.key

