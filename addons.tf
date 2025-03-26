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
  addon_version = "v1.11.4-eksbuild.2"
}


resource "aws_eks_addon" "eks_pod_identity_agent" {
  cluster_name = aws_eks_cluster.premium_cluster.name
  addon_name   = "eks-pod-identity-agent"
  addon_version = "v1.3.5-eksbuild.2"
}
