output "k8s_cluster_name" {
    value = digitalocean_kubernetes_cluster.k8s.name
}

output "k8s_cluster_endpoint" {
    value = digitalocean_kubernetes_cluster.k8s.endpoint
}

resource "local_file" "kubernetes_config" {
    filename = "kubeconfig.yaml"
    content = "${digitalocean_kubernetes_cluster.k8s.kube_config.0.raw_config}"
}