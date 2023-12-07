terraform {
  source = "git@github.com:terraform-aws-modules/terraform-aws-vpc.git?ref=v2.64.0"
    }

include {
  path = find_in_parent_folders()
}

locals {
common_vars = yamldecode(file("${find_in_parent_folders("common_vars.yaml")}"))
name = "vpc-${local.common_vars.env}"
}

inputs = {
    name = local.name
cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  
  tags = {
    Terraform = "true"
    Environment = local.common_vars.env
  }
}