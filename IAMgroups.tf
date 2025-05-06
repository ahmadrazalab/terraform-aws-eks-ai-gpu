# ========== IAM Groups ==========
#  ✅ IAM Groups (Reusable)
resource "aws_iam_group" "eks_admins" {
  name = "eks-admins"
}

resource "aws_iam_group" "eks_security" {
  name = "eks-security"
}

resource "aws_iam_group" "eks_devs" {
  name = "eks-devs"
}

# # ========== IAM USERS ==========

# === IAM Users ===
resource "aws_iam_user" "ahmad" {
  name = "ahmad"
}

resource "aws_iam_user" "asif" {
  name = "asif"
}

resource "aws_iam_user" "yogesh" {
  name = "yogesh"
}

resource "aws_iam_user" "vipin" {
  name = "vipin"
}

# === Group Memberships ===

# Ahmad → eks-admins
resource "aws_iam_user_group_membership" "ahmad_membership" {
  user   = aws_iam_user.ahmad.name
  groups = [aws_iam_group.eks_admins.name]
}

# Asif → eks-security
resource "aws_iam_user_group_membership" "asif_membership" {
  user   = aws_iam_user.asif.name
  groups = [aws_iam_group.eks_security.name]
}

# Yogesh & Vipin → eks-devs
resource "aws_iam_user_group_membership" "yogesh_membership" {
  user   = aws_iam_user.yogesh.name
  groups = [aws_iam_group.eks_devs.name]
}

resource "aws_iam_user_group_membership" "vipin_membership" {
  user   = aws_iam_user.vipin.name
  groups = [aws_iam_group.eks_devs.name]
}
