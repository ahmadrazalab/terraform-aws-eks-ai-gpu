
#  ✅ EKS Access Entries (Group-based)
# Admin Group Access Entry
resource "aws_eks_access_entry" "admins" {
  cluster_name  = aws_eks_cluster.premium_cluster.name
  principal_arn = aws_iam_group.eks_admins.arn
  type          = "STANDARD"
  user_name     = "eks-admins"
}

# Security Group Access Entry
resource "aws_eks_access_entry" "security" {
  cluster_name  = aws_eks_cluster.premium_cluster.name
  principal_arn = aws_iam_group.eks_security.arn
  type          = "STANDARD"
  user_name     = "eks-security"
}

# Dev Group Access Entry
resource "aws_eks_access_entry" "devs" {
  cluster_name  = aws_eks_cluster.premium_cluster.name
  principal_arn = aws_iam_group.eks_devs.arn
  type          = "STANDARD"
  user_name     = "eks-devs"
}

# ✅ EKS Policy Associations
# Admin Group - Full Access to Cluster
resource "aws_eks_access_policy_association" "admin_policy" {
  cluster_name  = aws_eks_cluster.premium_cluster.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = aws_iam_group.eks_admins.arn

  access_scope {
    type = "cluster"
  }
}

# Security Group - View Access to Cluster
resource "aws_eks_access_policy_association" "security_policy" {
  cluster_name  = aws_eks_cluster.premium_cluster.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSViewPolicy"
  principal_arn = aws_iam_group.eks_security.arn

  access_scope {
    type = "cluster"
  }
}

# Dev Group - View Access Only in 'staging' Namespace
resource "aws_eks_access_policy_association" "dev_policy" {
  cluster_name  = aws_eks_cluster.premium_cluster.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSViewPolicy"
  principal_arn = aws_iam_group.eks_devs.arn

  access_scope {
    type       = "namespace"
    namespaces = ["staging"]
  }
}
