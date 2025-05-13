variable "vpc_id" {
  description = "AWS Course VPC ID"
  type        = string
}

variable "security_vpc_id" {
  description = "Security VPC ID"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet ID"
  type        = string
}

variable "private_subnet_id" {
  description = "Private subnet ID"
  type        = string
}

variable "security_subnet_id" {
  description = "Security subnet ID"
  type        = string
}
