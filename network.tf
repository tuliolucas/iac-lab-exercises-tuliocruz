module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = ">= 3.0.0"

  name = var.prefix
  cidr = var.vpc_cidr

  azs             = slice(data.aws_availability_zones.available.names, 0, var.number_of_public_subnets)
  public_subnets  = [for i in range(var.number_of_public_subnets) : cidrsubnet(var.vpc_cidr, var.newbits, i)]
  private_subnets = [for i in range(var.number_of_private_subnets) : cidrsubnet(var.vpc_cidr, var.newbits, i + var.number_of_public_subnets)]
  enable_dns_hostnames = true
  enable_dns_support   = true

  single_nat_gateway = true
  enable_nat_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name        = var.prefix
  }
}