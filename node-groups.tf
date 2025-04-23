resource "aws_eks_node_group" "application_node_group" {
  cluster_name    = aws_eks_cluster.premium_cluster.name
  version = var.eks-node-version
  node_group_name = "application_node_group-${random_string.name_suffix.result}"
  node_role_arn   = aws_iam_role.node_group_role.arn
  subnet_ids      = var.public_subnet_ids

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 2
  }

  instance_types = var.application_instance_types
  ami_type = "AL2_x86_64" 
  node_repair_config {
    enabled = true
  }

  tags = {
    Name = "application_node_group"
  }
}

resource "aws_eks_node_group" "gpu_node_groups" {
  cluster_name    = aws_eks_cluster.premium_cluster.name
  version = var.eks-node-version
  node_group_name = "gpu_node_groups"
  node_role_arn   = aws_iam_role.node_group_role.arn
  subnet_ids      = var.public_subnet_ids

  scaling_config {
    desired_size = 0
    max_size     = 1
    min_size     = 0
  }

  instance_types = var.gpu_instance_types

update_config {
    max_unavailable = var.node_group_max_unavailable
  }
#   depends_on = [aws_iam_role_policy_attachment.node_group_policies]
  ami_type = "AL2_x86_64_GPU"  # Amazon Linux 2 AMI with GPU support

  tags = {
    Name = "gpu_node_groups"
  }
}
