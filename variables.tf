variable "region" {
  description = "The region where the resources will be created"
  default     = "eu-central-1"
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
  default     = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24"
  ]
}

variable "db_username" {
  description = "The username for the DocumentDB cluster"
  type        = string
}

variable "db_password" {
  description = "The password for the DocumentDB cluster"
  type        = string
  sensitive   = true
}

variable "key_name" {
  description = "The name of the SSH key pair"
  type        = string
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
  default = "ami-0e872aee57663ae2d"
}

variable "key_path" {
  description = "Path to the SSH private key"
  type        = string
}

variable "domain_name" {
  description = "The domain name to be used for the Route 53 hosted zone."
  type        = string
  default     = "cloudleaf.org"
}