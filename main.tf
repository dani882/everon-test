# Create self-signed certificate
module "selfcertificate" {
  source                  = "./Modules/selfcertificate"
  ca_public_key_file_path = "./Modules/docker-container/ca-nginx-selfsigned.crt"
  public_key_file_path    = "./Modules/docker-container/nginx-selfsigned.crt"
  private_key_file_path   = "./Modules/docker-container/nginx-selfsigned.key"
  owner                   = "dani882"
  organization_name       = "Everon Jesus Rivera test"
  ca_common_name          = "everon.test"
  common_name             = "everon.test"
  dns_names               = ["everon.test"]
  ip_addresses            = ["127.0.0.1"]
  validity_period_hours   = "12"
}

module "gke" {
  source   = "./Modules/gke"
  project  = "original-bolt-264015"
  location = "us-east1"
  region   = "us-east1"
}

module "kubernetes" {
  source = "./Modules/docker-container"
  #host                   = https://${module.gke.cluster_endpoint}
  #cluster_ca_certificate = module.gke.cluster_ca_certificate
  #token                  = data.google_client_config.current.access_token
}

output "lb_ip" {
  value = module.kubernetes.lb_ip
  description = "The IP address of the Kubernetes Load Balancer."
}