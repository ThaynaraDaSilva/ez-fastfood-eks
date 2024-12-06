variable "aws_region" {
  description = "Região onde os recursos da AWS serão criados (ex.: us-east-1)"
  type        = string
}

variable "cluster_name" {
  description = "Nome do cluster EKS"
  type        = string
}

variable "cluster_version" {
  description = "Versão do cluster EKS"
  type        = string
}

variable "vpc_name" {
  description = "Nome da VPC existente para filtrar o VPC ID dinamicamente"
  type        = string
}

variable "namespace_name" {
  description = "Nome do namespace no Kubernetes"
  type        = string
}

variable "ec2_key_name" {
  description = "Nome da chave SSH usada para acessar as instâncias EC2"
  type        = string
}

variable "environment" {
  description = "Ambiente da aplicação (ex.: dev, staging, prod)"
  type        = string
}

variable "project" {
  description = "Nome do projeto (ex.: ez-fast-food)"
  type        = string
}

variable "company" {
  description = "Nome da empresa"
  type        = string
}

variable "additional_subnet_cidr" {
  description = "CIDR Block da nova subnet a ser criada"
  type        = string
}

variable "az_index" {
  description = "Índice da Availability Zone para a nova subnet (ex.: 0 para a primeira AZ)"
  type        = number
  default     = 2
}

variable "public_route_table_tag" {
  description = "Tag usada para identificar a Route Table pública na VPC"
  type        = string
}