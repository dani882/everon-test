provider "kubernetes" {
  load_config_file       = false
  host                   = var.host
  cluster_ca_certificate = var.cluster_ca_certificate
  token                  = var.token
}

resource "kubernetes_deployment" "nginx" {
  metadata {
    name = "everon-nginx"
    labels = {
      App = "EveronTest"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        App = "EveronTest"
      }
    }

    template {
      metadata {
        labels = {
          App = "EveronTest"
        }
      }

      spec {
        container {
          image = "jrdevers/everon-nginx"
          name  = "everon-nginx"

          port {
            container_port = 443
          }


          resources {
            limits {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "nginx" {
  metadata {
    name = "everon-service-nginx"
  }
  spec {
    selector = {
      App = kubernetes_deployment.nginx.metadata[0].labels.App
    }
    port {
      port        = 443
      target_port = 443
    }

    type = "LoadBalancer"
  }
}
