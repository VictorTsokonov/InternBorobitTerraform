variable "region" {
  description = "The region where the resources will be created"
  default     = "eu-central-1"
}

variable "domain_name" {
  description = "The domain name to be used for the Route 53 hosted zone."
  type        = string
  default     = "cloudleaf.org"
}

variable "load_balancer_dns" {
  description = "The DNS name of the load balancer."
  type        = string
}
