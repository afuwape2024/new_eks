variable "vpc_id" {
	type = string
}

variable "ami" {
  default = "ami-0198cdf7458a7a932"
}
variable "instance_type" {
  default = "t2.large"
}
variable "web-security_group" {}

variable "web_subnet" {
  description = "Public subnet ID for EC2 instances"
}

variable "mandatory_tags" {
  type = map(string)
  default = {
    Name       = "3-tier-microservice-instance"
    Environment = "dev"
    Project     = "3-tier-microservice"
  }
}