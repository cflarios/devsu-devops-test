resource "digitalocean_kubernetes_cluster" "k8s" {
  name    = "k8s"
  region  = var.region
  version = var.k8s_version
  tags    = ["k8s"]
  node_pool {
    name       = "default"
    size       = "s-1vcpu-2gb"
    tags       = ["k8s", "worker", "default"]
    node_count = var.node_count
    auto_scale = true
    min_nodes  = var.min_nodes
    max_nodes  = var.max_nodes
  }
}

# resource "kubernetes_deployment_v1" "api" {
#   metadata {
#     name      = "api"
#     namespace = "kube-system"

#     labels = {
#       app = "api"
#     }
#   }

#   spec {
#     replicas = 2

#     selector {
#       match_labels = {
#         app = "api"
#       }
#     }

#     template {
#       metadata {
#         labels = {
#           app = "api"
#         }
#       }

#       spec {
#         container {
#           image = "cflarios/devsu_devops_assessment"
#           name  = "api"
#           port {
#             container_port = 8080
#           }

#           resources {
#             limits = {
#               cpu    = "0.5"
#               memory = "512Mi"
#             }
#             requests = {
#               cpu    = "250m"
#               memory = "50Mi"
#             }
#           }
#         }
#       }
#     }
#   }
# }

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
