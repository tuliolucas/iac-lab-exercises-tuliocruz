resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  instance_tenancy = "default"

  tags = {
    Name = var.prefix
  }
}

resource "aws_subnet" "public-subnet" {
  count = var.number_of_public_subnets
  vpc_id     = aws_vpc.main.id
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block = cidrsubnet(var.vpc_cidr, var.newbits, count.index)

  tags = {
    Name = format("%s-public-subnet-%d", var.prefix, count.index)
  }
}

resource "aws_subnet" "private-subnet" {
  count = var.number_of_private_subnets
  vpc_id     = aws_vpc.main.id
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block = cidrsubnet(var.vpc_cidr, var.newbits, count.index + var.number_of_public_subnets)
  tags = {
    Name = format("%s-private-subnet-%d", var.prefix, count.index)
  }
}

resource "aws_subnet" "secure-subnet" {
  count = var.number_of_private_subnets
  vpc_id     = aws_vpc.main.id
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block = cidrsubnet(var.vpc_cidr, var.newbits, count.index + var.number_of_public_subnets + var.number_of_private_subnets)
  tags = {
    Name = format("%s-secure-subnet-%d", var.prefix, count.index)
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = format("%s-gw", var.prefix)
  }
}

resource "aws_eip" "lb" {
  domain   = "vpc"
}

resource "aws_nat_gateway" "primary_nat" {
  allocation_id = aws_eip.lb.id
  subnet_id     = aws_subnet.public-subnet[0].id
  tags = {
      Name = format("%s-nat-gateway", var.prefix)
  }
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block        = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
      Name = format("%s-aws_public_route_table", var.prefix)
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block        = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.primary_nat.id
  }
  tags = {
      Name = format("%s-aws_private_route_table", var.prefix)
  }
}

resource "aws_route_table_association" "public_association" {
  count = var.number_of_public_subnets
  subnet_id      = aws_subnet.public-subnet[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_association" {
  count = var.number_of_private_subnets
  subnet_id      = aws_subnet.private-subnet[count.index].id
  route_table_id = aws_route_table.private_rt.id
}
