resource "aws_iam_role" "eks_dev_role" {
  name = "EKSDevRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          AWS = [
            aws_iam_user.dev1.arn,
            aws_iam_user.dev2.arn
          ]
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}


resource "aws_iam_policy" "assume_dev_role" {
  name = "AllowAssumeEKSDevRole"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "sts:AssumeRole",
        Resource = aws_iam_role.eks_dev_role.arn
      }
    ]
  })
}

resource "aws_iam_group_policy_attachment" "dev_assume_attach" {
  group      = aws_iam_group.eks_devs.name
  policy_arn = aws_iam_policy.assume_dev_role.arn
}



data "aws_caller_identity" "current" {}

data "aws_iam_role" "sso_eks_dev" {
  name = "AWSReservedSSO_EKSDevAccess_1234567890abcdef"  # Replace with actual role name
}

resource "aws_eks_access_entry" "dev_entry" {
  cluster_name  = aws_eks_cluster.premium_cluster.name
  principal_arn = data.aws_iam_role.sso_eks_dev.arn
  user_name     = "eks-devs"
}




resource "aws_eks_access_policy_association" "dev_policy" {
  cluster_name  = aws_eks_cluster.premium_cluster.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSViewPolicy"
  principal_arn = aws_iam_role.eks_dev_role.arn

  access_scope {
    type       = "namespace"
    namespaces = ["staging"]
  }
}
