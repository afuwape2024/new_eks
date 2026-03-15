variable "region" {
  type = string
}
variable "jenkins_vpc" {
  type = string
}
variable "cidr_block" {
  description = "CIDR block for the VPC"
  type = string
}
variable "availability_zones" {
  type = list(string)     
}
variable "public_subnet_cidr_block" {
    type = list(string)
}
variable "private_subnet_cidr_block" {
  type = list(string)
}