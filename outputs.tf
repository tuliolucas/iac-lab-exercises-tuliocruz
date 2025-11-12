output "vpc_id" {
  value =  module.vpc.vpc_id
  description = "The Id of the VPC created by the VPC module"
}
