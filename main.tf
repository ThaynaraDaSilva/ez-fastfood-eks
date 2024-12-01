provider "aws" {
  region = var.aws_region
}

# EKS Cluster
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = "1.27"

  vpc_id     = data.aws_vpc.selected.id
  subnet_ids = data.aws_subnet_ids.selected.ids

  tags = var.cluster_tags
}

resource "aws_eks_node_group" "ez_fast_food" {
  cluster_name    = module.eks.cluster_id
  node_group_name = "ez-fast-food-workers"
  node_role_arn   = aws_iam_role.worker_role.arn
  subnet_ids      = data.aws_subnet_ids.selected.ids

  scaling_config {
    desired_size = 1
    min_size     = 1
    max_size     = 1
  }

  instance_types = ["t2.micro"] # Free Tier elegível
  ami_type       = "AL2_x86_64"

  tags = {
    Environment = "dev"
    Project     = "ez-fast-food"
  }
}

resource "aws_iam_role" "worker_role" {
  name = "eks-worker-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "worker_role_policy" {
  role       = aws_iam_role.worker_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

# Data sources para referenciar VPC existente
data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnet_ids" "selected" {
  vpc_id = data.aws_vpc.selected.id
}

# Namespace para o projeto
resource "kubernetes_namespace" "ez_fast_food" {
  metadata {
    name = var.namespace_name
  }
}
