variable "prefix" {
  type        = string
  description = "Prefix for resource names"
  default = "tuliocruz-iac-lab"
}

variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "eu-north-1"
}

variable "repo_name" {
  type        = string
  description = "GitHub repository name"
  default = "tuliolucas/iac-lab-exercises-tuliocruz"
}

