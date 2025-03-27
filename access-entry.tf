resource "aws_eks_access_entry" "admin-user" {
  cluster_name = aws_eks_cluster.premium_cluster.name
  principal_arn = aws_iam_user.admin_user.arn
  type = "STANDARD"
  user_name = "admin-user"
}

resource "aws_eks_access_policy_association" "admin-user" {
  cluster_name  = aws_eks_cluster.premium_cluster.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = aws_iam_user.admin_user.arn

  access_scope {
    type = "cluster"
  }
}


#########################################33

resource "aws_eks_access_entry" "dev_user" {
  cluster_name = aws_eks_cluster.premium_cluster.name
  principal_arn = aws_iam_user.readonly_user.arn
  type = "STANDARD"
  user_name = "dev"
}

resource "aws_eks_access_policy_association" "dev-user" {
  cluster_name  = aws_eks_cluster.premium_cluster.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSViewPolicy"
  principal_arn = aws_iam_user.readonly_user.arn

  access_scope {
    type       = "namespace"
    namespaces = ["staging"]
  }
}