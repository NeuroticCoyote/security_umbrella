module "cluster" {
  source = "../../../cloud/linode/lke"

  label       = "the-security-project"
  k8s_version = "1.21"
  region      = "eu-central"
  tags        = ["prod"]
  pools = [
    {
      type  = "g6-standard-1"
      count = 3
    }
  ]
}

locals {
  config_path = "../../../secrets/prodconfig.yaml"
}

resource "local_file" "kube_config" {
  sensitive_content = base64decode(module.cluster.kubeconfig)
  filename          = local.config_path
  file_permission   = "0644"
}