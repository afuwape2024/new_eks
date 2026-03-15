module "jenkins_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "jenkins_vpc"
  cidr = "11.0.0.0/16"

  azs             = var.availability_zones
  private_subnets = var.private_subnet_cidr_block
  public_subnets  = var.public_subnet_cidr_block

  enable_nat_gateway = true
  enable_vpn_gateway = true
  single_nat_gateway = true

  tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
  } 
  public_subnet_tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
    "kubernetes.io/role/elb" = "1"
  }
  private_subnet_tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "jenkins-eks-cluster"
  cluster_version = "1.29"

  vpc_id     = module.jenkins_vpc.vpc_id
  subnet_ids = module.jenkins_vpc.private_subnets

  eks_managed_node_groups = {
    node_group_1 = {
      desired_size   = 2
      max_size       = 3
      min_size       = 1
      instance_types = ["t3.medium"]
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}

#========================================================
resource "aws_internet_gateway" "jenkin_ig" {
  vpc_id = module.jenkins_vpc.vpc_id
}

#==================================================================
resource "aws_subnet" "public_subnet" {
    vpc_id = module.jenkins_vpc.vpc_id
    cidr_block = var.public_subnet_cidr_block[0]
    availability_zone = var.availability_zones[0]
    map_public_ip_on_launch = true
}

#========================================================
resource "aws_route_table" "public_route_table" {
  vpc_id = module.jenkins_vpc.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.jenkin_ig.id
  }
}
