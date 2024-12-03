variable "aws_region" {
  description = "Região onde os recursos da AWS serão criados"
}

variable "cluster_name" {
  description = "Nome do cluster EKS"
}

variable "vpc_name" {
  description = "Nome da VPC existente"
}

variable "namespace_name" {
  description = "Nome do namespace no Kubernetes"
}

variable "ec2_key_name" {
  description = "Nome da chave SSH para as instâncias EC2"
}
variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "project" {
  description = "Project name"
  type        = string
}

variable "company" {
  description = "Company name"
  type        = string
}

variable "eks_service_url" {
  description = "URL do serviço exposto pelo EKS"
  type        = string
}
