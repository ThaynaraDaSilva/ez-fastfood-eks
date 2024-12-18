provider "aws" {
  region = var.aws_region
}

# Query the VPC by name or ID
data "aws_vpc" "eks_vpc" {
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
  version         = "~> 20.0"
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  vpc_id          = data.aws_vpc.eks_vpc.id

  # Use the subnet IDs from the aws_subnets data source
  subnet_ids = data.aws_subnets.selected.ids

  tags = {
    Environment = var.environment
    Project     = var.project
    Company     = var.company
  }
}

# IAM Users to Attach Policies
variable "eks_users" {
  default = ["terraform-dev-user", "github-dev-user"]
}

# # Replace aws-auth with Access Policy Associations
# resource "aws_eks_access_policy_association" "eks_access_policy_terraform_user" {
#   cluster_name  = module.eks_cluster.cluster_name
#   policy_arn    = "arn:aws:iam::aws:policy/AmazonEKSClusterAdminPolicy"
#   principal_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/terraform-dev-user"

#   access_scope {
#     type = "cluster"
#   }
# }

# resource "aws_eks_access_policy_association" "eks_access_policy_github_user" {
#   cluster_name  = module.eks_cluster.cluster_name
#   policy_arn    = "arn:aws:iam::aws:policy/AmazonEKSClusterAdminPolicy"
#   principal_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/github-dev-user"

#   access_scope {
#     type = "cluster"
#   }
# }

# Fetch AWS Account ID for user ARNs
data "aws_caller_identity" "current" {}
