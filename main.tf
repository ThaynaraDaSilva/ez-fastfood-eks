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

  tags = {
    Environment = var.environment
    Project     = var.project
    Company     = var.company
  }
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
    Environment = var.environment
    Project     = var.project
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

# API Gateway (HTTP API)
resource "aws_apigatewayv2_api" "http_api" {
  name          = "${var.project}-api"
  protocol_type = "HTTP"

  tags = {
    Environment = var.environment
    Project     = var.project
  }
}

# API Gateway Integration with EKS
resource "aws_apigatewayv2_integration" "eks_integration" {
  api_id                  = aws_apigatewayv2_api.http_api.id
  integration_type        = "HTTP_PROXY"
  integration_uri         = var.eks_service_url # URL exposta pelo serviço no EKS
  payload_format_version  = "1.0"
}

# API Gateway Route
resource "aws_apigatewayv2_route" "eks_route" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "ANY /{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.eks_integration.id}"
}

# API Gateway Stage
resource "aws_apigatewayv2_stage" "default_stage" {
  api_id      = aws_apigatewayv2_api.http_api.id
  name        = "$default"
  auto_deploy = true
}
