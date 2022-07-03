output "kubeconfig" {
  value = linode_lke_cluster.main.kubeconfig
  sensitive = true
}