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
  vpc_id     = var.subnet1_cidr
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
