terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.40.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "eu-north-1"
}

variable "author" {
  description = "The author of the infrastructure code repository"
  type        = string
  default     = "iac-lab-tuliocruz"
}

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  instance_tenancy = "default"

  tags = {
    Name = var.author
  }
}