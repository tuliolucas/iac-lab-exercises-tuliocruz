resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  instance_tenancy = "default"

  tags = {
    Name = var.prefix
  }
}

resource "aws_subnet" "subnet1_cidr" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet1_cidr
  availability_zone = "${var.aws_region}a"
  tags = {
    Name = format("%s-subnet-1", var.prefix)
  }
}

resource "aws_subnet" "subnet2_cidr" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet2_cidr
  availability_zone = "${var.aws_region}a"
  tags = {
    Name = format("%s-subnet-2", var.prefix)
  }
}

resource "aws_subnet" "subnet3_cidr" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet3_cidr
  availability_zone = "${var.aws_region}a"
  tags = {
    Name = format("%s-subnet-3", var.prefix)
  }
}

resource "aws_subnet" "subnet4_cidr" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet4_cidr
  availability_zone = "${var.aws_region}b"
  tags = {
    Name = format("%s-subnet-4", var.prefix)
  }
}

resource "aws_subnet" "subnet5_cidr" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet5_cidr
  availability_zone = "${var.aws_region}b"
  tags = {
    Name = format("%s-subnet-5", var.prefix)
  }
}

resource "aws_subnet" "subnet6_cidr" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet6_cidr
  availability_zone = "${var.aws_region}b"
  tags = {
    Name = format("%s-subnet-6", var.prefix)
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
  subnet_id     = aws_subnet.subnet1_cidr.id
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
    gateway_id = aws_nat_gateway.primary_nat.id

  }
  tags = {
      Name = format("%s-aws_private_route_table", var.prefix)
  }
}

resource "aws_route_table_association" "public_a_assoc_sn1" {
  subnet_id      = aws_subnet.subnet1_cidr.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_a_assoc_sn2" {
  subnet_id      = aws_subnet.subnet2_cidr.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_a_assoc_sn3" {
  subnet_id      = aws_subnet.subnet3_cidr.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_a_assoc_sn4" {
  subnet_id      = aws_subnet.subnet4_cidr.id
  route_table_id = aws_route_table.private_rt.id
}
