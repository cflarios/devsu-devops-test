variable "digitalocean_token" {
    description = "Digital Ocean API token"
    default = "dop_v1_5441a4ebed56e3160d401ddd8e8b84e270fd66205a280786461d23983c6be372" 
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