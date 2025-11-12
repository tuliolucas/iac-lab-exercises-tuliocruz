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

variable "db_username" {
  type        = string
  description = "Database username"
}

variable "db_name" {
  type        = string
  description = "Database name"
}