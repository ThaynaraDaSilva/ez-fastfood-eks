provider "aws" {
  region = var.aws_region
}

data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "additional_public_subnet" {
  vpc_id                  = data.aws_vpc.selected.id
  cidr_block              = var.additional_subnet_cidr
  availability_zone       = data.aws_availability_zones.available.names[var.az_index]
  map_public_ip_on_launch = true

  tags = {
    Name        = "vpc-${var.environment}-public-subnet-${data.aws_availability_zones.available.names[var.az_index]}"
    Environment = var.environment
    Project     = var.project
  }
}

data "aws_route_table" "public_route_table" {
  filter {
    name   = "tag:Name"
    values = [var.public_route_table_tag]
  }
  vpc_id = data.aws_vpc.selected.id
}

resource "aws_route_table_association" "additional_public_subnet_association" {
  subnet_id      = aws_subnet.additional_public_subnet.id
  route_table_id = data.aws_route_table.public_route_table.id
}