# ========== IAM Groups ==========
resource "aws_iam_group" "eks_admins" {
  name = "eks-admins"
}

resource "aws_iam_group" "devs-grp" {
  name = "eks-devs"
}



# # ========== IAM USERS ==========

# asif 
resource "aws_iam_user" "dev_asif" {
  name = "dev_asif"
}

resource "aws_iam_user_group_membership" "devs-grp_membership_asif" {
  user = aws_iam_user.dev_asif.name
  groups = [aws_iam_group.devs-grp.name]
}

# yogesh 
resource "aws_iam_user" "dev_yogesh" {
  name = "dev_yogesh"
}

resource "aws_iam_user_group_membership" "devs-grp_membership_yogesh" {
  user = aws_iam_user.dev_yogesh.name
  groups = [aws_iam_group.devs-grp.name]
}

# ahmad
resource "aws_iam_user" "eks_admin_ahmad" {
  name = "eks-admin-ahmad"
}

resource "aws_iam_user_group_membership" "eks_admins_membership_ahmad" {
  user = aws_iam_user.eks_admin_ahmad.name
  groups = [aws_iam_group.eks_admins.name]
}

