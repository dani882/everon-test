data "google_client_config" "current" {
}

provider "kubernetes" {
  load_config_file       = false
  host                   = "https://${module.gke.cluster_endpoint}"
  cluster_ca_certificate = module.gke.cluster_ca_certificate
  token                  = data.google_client_config.current.access_token
}

resource "kubernetes_pod" "nginx" {
  metadata {
    name = "everon-nginx"
    labels = {
      App = "nginx"
    }
  }

  spec {
    container {
      image = "gcr.io/original-bolt-264015/everon-nginx"
      name  = "everon-nginx"

      port {
        container_port = 443
      }
    }
  }
}

resource "kubernetes_service" "nginx" {
  metadata {
    name = "everon-nginx"
  }
  spec {
    selector = {
      App = kubernetes_pod.nginx.metadata[0].labels.App
    }
    port {
      port        = 443
      target_port = 443
    }

    type = "LoadBalancer"
  }
}
