resource "aws_eks_addon" "kube_proxy" {
  cluster_name = aws_eks_cluster.premium_cluster.name
  addon_name   = "kube-proxy"
  addon_version = "v1.31.3-eksbuild.2"

}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name = aws_eks_cluster.premium_cluster.name
  addon_name   = "vpc-cni"
  addon_version = "v1.19.3-eksbuild.1"
}

resource "aws_eks_addon" "coredns" {
  cluster_name = aws_eks_cluster.premium_cluster.name
  addon_name   = "coredns"
  addon_version = "v1.11.4-eksbuild.10"  
}


resource "aws_eks_addon" "eks_pod_identity_agent" {
  cluster_name = aws_eks_cluster.premium_cluster.name
  addon_name   = "eks-pod-identity-agent"
  addon_version = "v1.3.5-eksbuild.2"
}

resource "aws_eks_addon" "metrics_server" {
  cluster_name = aws_eks_cluster.premium_cluster.name
  addon_name   = "metrics-server"
  addon_version = "v0.7.2-eksbuild.3"  
}

resource "aws_eks_addon" "ebs_csi_driver" {
  cluster_name    = aws_eks_cluster.premium_cluster.name
  addon_name      = "aws-ebs-csi-driver"
  addon_version   = "v1.42.0-eksbuild.1"
  service_account_role_arn = aws_iam_role.eks_pod_identity_ebs_csi_driver_role.arn
  
}
