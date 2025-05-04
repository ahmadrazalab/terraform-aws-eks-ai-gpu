# resource "aws_eks_access_entry" "root" {
#   cluster_name   = aws_eks_cluster.premium_cluster.name
#   principal_arn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
#   type           = "STANDARD"
#   user_name      = "root"
# }



# # ========== EKS Access Entries ==========
# resource "aws_eks_access_entry" "admin_user" {
#   cluster_name   = aws_eks_cluster.premium_cluster.name
#   principal_arn  = aws_iam_user.admin_user.arn
#   type           = "STANDARD"
#   user_name      = "admin-user"
# }

# resource "aws_eks_access_policy_association" "admin_user_policy" {
#   cluster_name   = aws_eks_cluster.premium_cluster.name
#   policy_arn     = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
#   principal_arn  = aws_iam_user.admin_user.arn

#   access_scope {
#     type = "cluster"
#   }
# }

# resource "aws_eks_access_entry" "readonly_user" {
#   cluster_name   = aws_eks_cluster.premium_cluster.name
#   principal_arn  = aws_iam_user.readonly_user.arn
#   type           = "STANDARD"
#   user_name      = "readonly-user"
# }

# resource "aws_eks_access_policy_association" "readonly_user_policy" {
#   cluster_name   = aws_eks_cluster.premium_cluster.name
#   policy_arn     = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSViewPolicy"
#   principal_arn  = aws_iam_user.readonly_user.arn

#   access_scope {
#     type       = "namespace"
#     namespaces = ["staging"]
#   }
# }
