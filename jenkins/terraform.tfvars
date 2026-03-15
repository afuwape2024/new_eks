region                = "us-east-2"
jenkins_vpc           = "jenkins-vpc"
cidr_block        = "10.1.0.0/16"
public_subnet_cidr_block  = ["10.1.1.0/24", "10.1.2.0/24"]
private_subnet_cidr_block = ["10.1.101.0/24", "10.1.102.0/24"]
availability_zones        = ["us-east-2a", "us-east-2b"]