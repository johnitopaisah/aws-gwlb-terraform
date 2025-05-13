variable "gwlb_subnet_id" {
  description = "Subnet ID in the Security VPC for Gateway Load Balancer"
  type        = string
}

variable "vpc_ids" {
  description = "List of VPC IDs"
  type        = list(string)
}