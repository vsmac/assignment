provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {}
  required_version = ">= 0.14.4"
}

data "aws_caller_identity" "current" {}

resource "aws_iam_role" "cluster_role" {
  name               = "${var.name}-cluster-role"
  assume_role_policy = templatefile("${path.module}/templates/cluster-role.json", {})
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster_role.name
}

resource "aws_eks_cluster" "cluster" {
  name                      = var.name
  role_arn                  = aws_iam_role.cluster_role.arn
  version                   = var.cluster_version
  enabled_cluster_log_types = var.cluster_log_types

  vpc_config {
    subnet_ids = var.stateful_worker_subnet_ids
  }

  tags = {
    Name        = var.name
    Environment = var.environment
    provisioner = "terraform"
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
  ]
}

resource "aws_iam_role" "node_group_role" {
  name               = "${var.name}-node-group-role"
  assume_role_policy = templatefile("${path.module}/templates/node-group-role.json", {})
}

resource "aws_iam_policy" "ExternalDNSPolicy" {
  name   = "${var.name}-ExternalDNSPolicy"
  policy = templatefile("${path.module}/templates/external-dns-policy.json", {})
}

resource "aws_iam_role" "externalDNSRole" {
  name = "${var.name}-ExternalDNSRole"
  assume_role_policy = templatefile("${path.module}/templates/external-dns-role.json", {
    account_id  = data.aws_caller_identity.current.account_id
    oidc        = replace(aws_eks_cluster.cluster.identity[0].oidc[0].issuer, "https://", "")
    environment = var.environment
  })
}

resource "aws_iam_role_policy_attachment" "externalDNSPolicyAttach" {
  policy_arn = aws_iam_policy.ExternalDNSPolicy.arn
  role       = aws_iam_role.externalDNSRole.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node_group_role.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.node_group_role.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node_group_role.name
}

resource "aws_eks_node_group" "stateful" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "${var.name}-stateful-node-group"
  node_role_arn   = aws_iam_role.node_group_role.arn
  subnet_ids      = var.stateful_worker_subnet_ids
  instance_types  = [var.stateful_worker_instance_type]
  disk_size       = var.stateful_worker_disk_size

  scaling_config {
    desired_size = var.stateful_worker_desired_size
    max_size     = var.stateful_worker_max_size
    min_size     = var.stateful_worker_min_size
  }

  labels = {
    stateful = true
  }

  tags = {
    Name        = var.name
    Environment = var.environment
    provisioner = "terraform"
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
  ]
}

