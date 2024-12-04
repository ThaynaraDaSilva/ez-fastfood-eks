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
variable "vpc_id" {
  description = "ID da VPC onde a nova subnet será criada"
  type        = string
}

variable "additional_subnet_cidr" {
  description = "CIDR Block da nova subnet"
  type        = string
}

variable "az_index" {
  description = "Índice da AZ adicional (baseado na lista de AZs disponíveis)"
  type        = number
  default     = 2 # Por padrão, pega a terceira AZ da lista
}

variable "public_route_table_id" {
  description = "ID da Route Table pública"
  type        = string
}
