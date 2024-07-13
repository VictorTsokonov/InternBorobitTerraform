variable "region" {
  description = "The region where the resources will be created"
  default     = "eu-central-1"
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
}
