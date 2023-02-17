variable "digitalocean_token" {
    description = "Digital Ocean API token"
    default = var.digitalocean_token
}

variable "region" {
  default = "nyc1"
}

variable "k8s_version" {
  default = "1.23.14-do.0"
}

variable "node_count" {
  description = "number of nodes in the cluster"
  default = 2
}

variable "min_nodes" {
  description = "minimum number of nodes in the cluster"
  default = 1
}

variable "max_nodes" {
  description = "maximum number of nodes in the cluster"
  default = 2
}