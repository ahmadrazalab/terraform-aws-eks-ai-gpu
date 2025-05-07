resource "random_string" "name_suffix" {
  length  = 10
  upper   = false
  special = false
}

resource "aws_eks_cluster" "premium_cluster" {
  name     = "premium-${random_string.name_suffix.result}"
  role_arn = aws_iam_role.eks_autocluster_role.arn
  version  = var.eks-version


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


## OIDC Provider for EKS
# This provider is used for the AWS Load Balancer Controller
# and other AWS services that require IAM roles for service accounts.
# Get EKS cluster details (must match your existing EKS cluster name)
# data "aws_eks_cluster" "oidc" {
#   name = aws_eks_cluster.premium_cluster.name
# }

# # Get the TLS thumbprint from the OIDC issuer
# data "tls_certificate" "oidc_thumbprint" {
#   url = data.aws_eks_cluster.oidc.identity[0].oidc[0].issuer
# }

# # Create the OIDC provider
# resource "aws_iam_openid_connect_provider" "eks_oidc" {
#   client_id_list  = ["sts.amazonaws.com"]
#   thumbprint_list = [data.tls_certificate.oidc_thumbprint.certificates[0].sha1_fingerprint]
#   url             = data.aws_eks_cluster.oidc.identity[0].oidc[0].issuer

#   tags = {
#     Name = "eks-oidc-provider"
#   }
# }
