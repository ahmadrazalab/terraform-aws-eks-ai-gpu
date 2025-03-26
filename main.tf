resource "random_string" "name_suffix" {
  length  = 8
  upper   = false
  special = false
}

resource "aws_eks_cluster" "premium_cluster" {
  name     = "premium-${random_string.name_suffix.result}"
  role_arn = aws_iam_role.eks_autocluster_role.arn
  version = "1.31"

  access_config {
    authentication_mode = "API"
  }

  upgrade_policy {
    support_type = "STANDARD"
  }

  vpc_config {
    subnet_ids              = var.private_subnet_ids
    endpoint_private_access = true
    endpoint_public_access  = false
  
  }


  # kubernetes_network_config {
  #   service_ipv4_cidr = "10.100.0.0/16"
  # }

  # enabled_cluster_log_types = var.enabled_cluster_log_types

  tags = var.cluster_tags
}



