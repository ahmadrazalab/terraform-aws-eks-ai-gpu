resource "aws_eks_access_entry" "admin-user" {
  cluster_name = aws_eks_cluster.premium_cluster.name
  principal_arn = aws_iam_user.admin_user.arn
  type = "STANDARD"
  user_name = "admin-user"
}


resource "aws_eks_access_entry" "administrator" {
  cluster_name = aws_eks_cluster.premium_cluster.name
  principal_arn = aws_iam_user.admin_user.arn
  type = "STANDARD"
  user_name = "admin"
}
