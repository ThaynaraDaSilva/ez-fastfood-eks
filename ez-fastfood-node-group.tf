resource "aws_eks_node_group" "ez_fast_food" {
  cluster_name    = module.eks.cluster_id
  node_group_name = "ez-fast-food-workers"
  node_role_arn   = aws_iam_role.worker_role.arn
  subnet_ids      = data.aws_subnets.selected.ids

  scaling_config {
    desired_size = 1
    min_size     = 1
    max_size     = 1
  }

  instance_types = ["t2.micro"] # Free Tier elegível
  ami_type       = "AL2_x86_64"

  tags = {
    Environment = var.environment
    Project     = var.project
  }
}

# Role para o node group
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

# Anexando políticas necessárias à role
resource "aws_iam_role_policy_attachment" "worker_role_policy" {
  role       = aws_iam_role.worker_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "worker_role_cni_policy" {
  role       = aws_iam_role.worker_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSCNIPolicy"
}

resource "aws_iam_role_policy_attachment" "worker_role_registry_policy" {
  role       = aws_iam_role.worker_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}
