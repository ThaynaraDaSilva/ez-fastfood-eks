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

variable "node_group_name" {
  description = "Nome do Node Group EKS"
  type        = string
}

variable "instance_types" {
  description = "Tipos de instâncias para os Nodes do EKS"
  type        = list(string)
}

variable "desired_capacity" {
  description = "Capacidade desejada do Node Group"
  type        = number
}

variable "min_size" {
  description = "Capacidade mínima do Node Group"
  type        = number
}

variable "max_size" {
  description = "Capacidade máxima do Node Group"
  type        = number
}

variable "capacity_type"{
  description = "Tipo de capacidade"
  type        = string
}

variable "aws_access_key" {
  description = "AWS Access Key ID"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS Secret Access Key"
  type        = string
  sensitive   = true
}