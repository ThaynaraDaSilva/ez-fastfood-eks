provider "aws" {
  region = var.aws_region
}

# Query the VPC by name or ID (depending on your need)
data "aws_vpc" "eks_vpc" {
  # You can filter by VPC name or ID, depending on how you want to reference the VPC
  # If you want to filter by name, use the following:
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]  # Assuming vpc_name is a variable containing the VPC's name
  }
}

# Query subnets in the VPC
data "aws_subnets" "selected" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.eks_vpc.id]  # Reference to the VPC ID
  }

  filter {
    name   = "availabilityZone"
    values = ["us-east-1a", "us-east-1b"]  # Specify desired availability zones
  }
}

# EKS Cluster setup
module "eks_cluster" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  vpc_id          = data.aws_vpc.eks_vpc.id

  # Use the subnet IDs from the aws_subnets data source
  subnet_ids      = data.aws_subnets.selected.ids  # Reference the selected subnets

  tags = {
    Environment = var.environment
    Project     = var.project
    Company     = var.company
  }
}
