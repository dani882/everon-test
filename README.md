# Demo project using Terraform and Google GKE


## Overview


A basic dockerized nginx image to be deployed to Google Kubernetes Engine(GKE)

The image is based on nginx from dockerhub and have been modified using Dockerfile.

The application is running in a GKE cluster that needs a minimum of two instances at all times (in separate Availability zones for redundancy) and a maximum of 5 scaling up automatically the number of instances

## Template details

The templates below are included in this repository and reference architecture:

| Template | Description |
| --- | --- | 
| [main.tf](main.tf) | This is the principal file - initialize all modules. |
| [Modules/docker-container/main.tf](Modules/docker-container/main.tf) | This module deploys a kubernetes deployment to GKE cluser |
| [Modules/gke/main.tf](Modules/gke/main.tf) | This module creates the GKE cluster

After the Terraform modules have been deployed, the [outputs](https://www.terraform.io/docs/configuration/outputs.html) contain a link to the load-balanced URL of the deployed application.


## Provisioning infrastructure

### Tools needed:
We need to have gcloud cli configured, docker, kubectl and terraform installed.

### Steps for Create GKE cluster and deploy image

- Clone this repository
- Execute ``` bash push_gke.sh ``` to create the gke cluster
- Once script have finished, It will show the load-balanced URL of the deployed application
