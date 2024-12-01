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

variable "cluster_tags" {
  description = "Tags para o cluster EKS"
  type        = map(string)
}
