variable "prefix" {
  type        = string
  description = "tuliocruz-iac-lab"
}

variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR block"
}

variable "subnet1_cidr" {
  type        = string
  description = "Subnet 1 CIDR block"
}

variable "subnet2_cidr" {
  type        = string
  description = "Subnet 2 CIDR block"
}

variable "subnet3_cidr" {
  type        = string
  description = "Subnet 3 CIDR block"
}

variable "subnet4_cidr" {
  type        = string
  description = "Subnet 4 CIDR block"
}

variable "subnet5_cidr" {
  type        = string
  description = "Subnet 5 CIDR block"
}

variable "subnet6_cidr" {
  type        = string
  description = "Subnet 6 CIDR block"
}

variable "number_of_public_subnets" {
  type        = number
  description = "Number of public subnets"
  default     = 2
}

variable "number_of_private_subnets" {
  type        = number
  description = "Number of private subnets"
  default     = 2
}

variable "number_of_secure_subnets" {
  type        = number
  description = "Number of secure subnets"
  default     = 2
}

variable "newbits" {
  type        = number
  description = "New bits for subnetting"
  default     = 3
}