terraform {
  required_providers {
    kind = {
      source = "tehcyx/kind"
      version = "~> 0.2.0"
    }
  }
}

provider "kind" {}

# Kubernetes Cluster tanımı
resource "kind_cluster" "benim_cluster" {
  name           = "devops-cluster"
  wait_for_ready = true

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    node {
      role = "control-plane"
    }

    node {
      role = "worker"
    }

    node {
      role = "worker"
    }
  }
}
