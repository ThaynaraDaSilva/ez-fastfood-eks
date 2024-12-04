provider "aws" {
  region = var.aws_region
}


module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = "1.27"

  vpc_id     = data.aws_vpc.eks_vpc.id # Usar o VPC ID filtrado automaticamente
  subnet_ids = concat(data.aws_subnet_ids.selected.ids, [aws_subnet.additional_public_subnet.id])

  tags = {
    Environment = var.environment
    Project     = var.project
    Company     = var.company
  }
}

# Data source para referenciar a VPC existente
data "aws_vpc" "eks_vpc" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

# Data source para referenciar as subnets na VPC
data "aws_subnets" "selected" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.eks_vpc.id]
  }
}