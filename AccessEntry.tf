# resource "aws_iam_group" "eks_admins" {
#   name = "eks-admins"
# }

# resource "aws_iam_user" "ahmad" {
#   name = "ahmad"
# }

# resource "aws_iam_user_group_membership" "ahmad_group_membership" {
#   user   = aws_iam_user.ahmad.name
#   groups = [aws_iam_group.eks_admins.name]
# }


# resource "aws_iam_role" "eks_admin_role" {
#   name = "EKSAdminRole"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect = "Allow",
#         Principal = {
#           AWS = [
#             for user in aws_iam_group.eks_admins.users : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${user}"
#           ]
#         },
#         Action = "sts:AssumeRole"
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "eks_admin_policy_attach" {
#   role       = aws_iam_role.eks_admin_role.name
#   policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
# }

# resource "aws_eks_access_entry" "eks_admin_entry" {
#   cluster_name  = aws_eks_cluster.premium_cluster.name
#   principal_arn = aws_iam_role.eks_admin_role.arn
#   user_name     = "eks-admins"
#   type          = "STANDARD"
# }

# resource "aws_eks_access_policy_association" "eks_admin_association" {
#   cluster_name  = aws_eks_cluster.premium_cluster.name
#   principal_arn = aws_iam_role.eks_admin_role.arn
#   policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

#   access_scope {
#     type = "cluster"
#   }
# }
