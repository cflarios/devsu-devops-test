resource "digitalocean_kubernetes_cluster" "k8s" {
  name    = "k8s"
  region  = var.region
  version = var.k8s_version
  tags    = ["k8s"]
  node_pool {
    name       = "devsu"
    size       = "s-1vcpu-2gb"
    tags       = ["k8s", "worker", "devsu"]
    node_count = var.node_count
    auto_scale = true
    min_nodes  = var.min_nodes
    max_nodes  = var.max_nodes
  }
}

resource "kubernetes_deployment" "api" {
  metadata {
    name      = "api-terraform"
    namespace = "kube-system"

    labels = {
      app = "api"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "api"
      }
    }

    template {
      metadata {
        labels = {
          app = "api"
        }
      }

      spec {
        container {
          image = "cflarios/devsu_devops_assessment:latest"
          name  = "app"
          port {
            container_port = 3001
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }

  timeouts {
    create = "20m"
    update = "20m"
  }
}

resource "kubernetes_service" "api" {

  metadata {
    name      = "api-terraform"
    namespace = "kube-system"
  }
  spec {
    selector = {
      app = kubernetes_deployment.api.metadata[0].labels.app
    }

    session_affinity = "ClientIP"

    port {
      port        = 80
      target_port = 3001
    }

    type = "LoadBalancer"
  }
}
resource "digitalocean_loadbalancer" "lb" {
  name      = "my-lb"
  region    = var.region
  algorithm = "round_robin"
  forwarding_rule {
    entry_port      = 80
    entry_protocol  = "http"
    target_port     = 80
    target_protocol = "http"
  }

  healthcheck {
    protocol = "tcp"
    port     = 22
  }

  droplet_tag = "k8s"
}
