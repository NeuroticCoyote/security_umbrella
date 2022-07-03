terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "1.20.2"
    }
  }
}

resource "linode_lke_cluster" "main" {
  label       = var.label
  k8s_version = var.k8s_version
  region      = var.region
  tags        = var.tags

  dynamic "pool" {
    for_each = var.pools
    content {
      type  = pool.value["type"]
      count = pool.value["count"]
    }
  }
}