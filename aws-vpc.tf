module "vpc" {
  source                        = "terraform-aws-modules/vpc/aws"
  version                       = "3.4.0"
  name                          = "vpc-serverless"
  cidr                          = "10.0.0.0/16"
  azs                           = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets               = ["10.0.1.0/24","10.0.3.0/24","10.0.5.0/24"]
  public_subnets                = ["10.0.2.0/24","10.0.4.0/24","10.0.6.0/24"]
  enable_nat_gateway            = true
  single_nat_gateway            = true
  enable_dns_hostnames          = true
  manage_default_security_group = true
  default_security_group_name   = "vpc-serverless-security-group"
  
  public_subnet_tags = {
    "kubernetes.io/cluster/vpc-serverless" = "shared"
    "kubernetes.io/role/elb"               = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/vpc-serverless" = "shared"
    "kubernetes.io/role/internal-elb"      = "1"
  }

  tags = {
    "kubernetes.io/cluster/vpc-serverless" = "shared"
  }

}
