data google_client_config "current" {}

module "gke" {
  source   = "./Modules/gke"
  project  = "original-bolt-264015"
  location = "us-east1"
  region   = "us-east1"
}

module "kubernetes" {
  source = "./Modules/docker-container"
  host                   = "https://${module.gke.cluster_endpoint}"
  cluster_ca_certificate = module.gke.cluster_ca_certificate
  token                  = data.google_client_config.current.access_token
}

output "lb_ip" {
  value = "https://${module.kubernetes.lb_ip}"
  description = "The IP address of the Kubernetes Load Balancer."
}
