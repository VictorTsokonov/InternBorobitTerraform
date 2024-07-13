variable "db_username" {
  description = "The username for the DocumentDB cluster"
  type        = string
}

variable "db_password" {
  description = "The password for the DocumentDB cluster"
  type        = string
  sensitive   = true
}

variable "public_subnets" {
  description = "List of public subnets"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID"
  type        = string
}
