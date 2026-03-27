resource "aws_vpc" "epam-tf-practice" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "epam-tf-practice" {
  for_each = {
    for subnet in var.public_subnets : subnet.name => subnet
  }

  vpc_id                  = aws_vpc.epam-tf-practice.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = each.value.name
  }
}

resource "aws_internet_gateway" "epam-tf-practice" {
  vpc_id = aws_vpc.epam-tf-practice.id

  tags = {
    Name = var.igw_name
  }
}

resource "aws_route_table" "epam-tf-practice" {
  vpc_id = aws_vpc.epam-tf-practice.id

  tags = {
    Name = var.route_table_name
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.epam-tf-practice.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.epam-tf-practice.id
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.epam-tf-practice

  subnet_id      = each.value.id
  route_table_id = aws_route_table.epam-tf-practice.id
}
