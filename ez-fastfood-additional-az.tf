# main.tf
# Data source para listar todas as AZs disponíveis
# Filtrar o VPC ID pelo nome da tag
data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name] # Nome da VPC que será filtrada
  }
}

# Usar o VPC ID selecionado em recursos
resource "aws_subnet" "additional_public_subnet" {
  vpc_id            = data.aws_vpc.selected.id
  cidr_block        = var.additional_subnet_cidr
  availability_zone = data.aws_availability_zones.available.names[var.az_index]
  map_public_ip_on_launch = true

  tags = {
    Name        = "vpc-${var.environment}-public-subnet-${data.aws_vpc.selected.id}"
    Environment = var.environment
    Project     = var.project
  }
}

# Associação com a Route Table Pública
resource "aws_route_table_association" "additional_public_subnet_association" {
  subnet_id      = aws_subnet.additional_public_subnet.id
  route_table_id = var.public_route_table_id
}
