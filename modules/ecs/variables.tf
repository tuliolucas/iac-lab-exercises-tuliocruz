variable "prefix" {
  type        = string
  description = "tuliocruz-iac-lab"
}

variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Private subnet IDs"
}

variable "alb_target_group_arn" {
  type        = string
  description = "ALB target group ARN"
}

variable "alb_security_group_id" {
  type        = string
  description = "ALB security group ID"
}

variable "db_username" {
  type        = string
  description = "Database username"
}

variable "db_name" {
  type        = string
  description = "Database name"
}

variable "db_secret_arn" {
  type        = string
  description = "ARN of the secret in AWS Secrets Manager"
}

variable "db_secret_key_id" {
  type        = string
  description = "Key ID for the secret in AWS Secrets Manager"
} 

variable "db_address" {
  type        = string
  description = "Database address"
} 