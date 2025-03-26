# AUTO MODE CLUSTER ROLE
resource "aws_iam_role" "eks_autocluster_role" {
  name = "AmazonEKSAutoClusterRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = {
        Service = "eks.amazonaws.com"
      },
      Action    = [
        "sts:TagSession",
        "sts:AssumeRole"
      ]
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_autocluster_policies" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AmazonEKSBlockStoragePolicy",
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
    "arn:aws:iam::aws:policy/AmazonEKSComputePolicy",
    "arn:aws:iam::aws:policy/AmazonEKSLoadBalancingPolicy",
    "arn:aws:iam::aws:policy/AmazonEKSNetworkingPolicy"
  ])

  policy_arn = each.key
  role       = aws_iam_role.eks_autocluster_role.name
}

# AUTO NODE CLUSTER ROLE 

resource "aws_iam_role" "eks_auto_node_role" {
  name = "AmazonEKSAutoNodeRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_auto_node_policies" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPullOnly",
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodeMinimalPolicy"
  ])

  policy_arn = each.key
  role       = aws_iam_role.eks_auto_node_role.name
}


# # AmazonEKSPodIdentityAmazonVPCCNIRole

resource "aws_iam_role" "eks_pod_identity_role" {
  name = "AmazonEKSPodIdentityAmazonVPCCNIRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = {
        Service = "pods.eks.amazonaws.com"
      },
      Action    = ["sts:AssumeRole", "sts:TagSession"]
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_pod_identity_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_pod_identity_role.name
}

## AmazonEKSPodIdentityAmazonEBSCSIDriverRole

resource "aws_iam_role" "eks_pod_identity_ebs_csi_driver_role" {
  name = "AmazonEKSPodIdentityAmazonEBSCSIDriverRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = {
        Service = "pods.eks.amazonaws.com"
      },
      Action    = ["sts:AssumeRole", "sts:TagSession"]
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_pod_identity_ebs_csi_driver_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = aws_iam_role.eks_pod_identity_ebs_csi_driver_role.name
}