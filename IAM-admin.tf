resource "aws_iam_user" "admin_user" {
  name = "eks-admin"
}

resource "aws_iam_user_policy_attachment" "admin_user_policy_attachment" {
  user       = aws_iam_user.admin_user.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_user" "readonly_user" {
  name = "eks-dev"
}

resource "aws_iam_policy" "readonly_policy" {
  name        = "eks-readonly-policy"
  description = "Read-only access to EKS cluster and full access to specific resource group"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "eks:Describe*",
          "eks:List*"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "readonly_user_policy_attachment" {
  user       = aws_iam_user.readonly_user.name
  policy_arn = aws_iam_policy.readonly_policy.arn
}
