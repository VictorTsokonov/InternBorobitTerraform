variable "region" {}
variable "vpc_id" {}
variable "public_subnets" {
  type = list(string)
}
variable "ami_id" {}
variable "key_name" {}
variable "db_username" {}
variable "db_password" {}
variable "db_host" {}
variable "db_name" {}
