resource "random_string" "name_suffix" {
  length  = 10
  upper   = false
  special = false
}

resource "aws_eks_cluster" "premium_cluster" {
  name     = "premium-${random_string.name_suffix.result}"
  role_arn = aws_iam_role.eks_autocluster_role.arn
  version = var.eks-version


  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
  }

  upgrade_policy {
    support_type = "STANDARD"
  }

  # enabled_cluster_log_types = ["api", "audit", "authenticator"]


  vpc_config {
    subnet_ids              = var.public_subnet_ids
    endpoint_private_access = true
    endpoint_public_access  = true
    public_access_cidrs     = ["0.0.0.0/0"] # Adjust CIDR blocks as needed for security
  
  }
    tags = var.cluster_tags
}



