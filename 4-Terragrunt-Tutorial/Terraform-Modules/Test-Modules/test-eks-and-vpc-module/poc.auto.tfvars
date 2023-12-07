###################
# VPC Inputs
###################
vpc_name               = "poc"
vpc_base_cidr          = "10.1.0.0/16"

availability_zones     = ["us-west-1a", "us-west-1b"]
private_subnets        = "10.1.11.0/24,10.1.12.0/24"
public_subnets         = "10.1.21.0/24,10.1.22.0/24"
isolated_subnets       = "10.1.31.0/24,10.1.32.0/24"


###################
# EKS Inputs
###################

region                          = "us-west-1"
cluster_name                    = "new-poc"
cluster_version                 = "1.25"

cluster_endpoint_private_access = false
cluster_endpoint_public_access  = true

# vpc_id                          = 
# subnets                         = 
project_name                    = "poc"

eks_managed_node_groups = {
  # default_node_group = {
  #   # By default, the module creates a launch template to ensure tags are propagated to instances, etc.,
  #   # so we need to disable it to use the default template provided by the AWS EKS managed node group service
  #   use_custom_launch_template = false
  #   disk_size = 50
  # }

  custom_ami = {
      #ami_type = "AL2_ARM_64"
      # Current default AMI used by managed node groups - pseudo "custom"
      ami_id = "ami-057c8e758e31d7029"

      # This will ensure the bootstrap user data is used to join the node
      # By default, EKS managed node groups will not append bootstrap script;
      # this adds it back in using the default template provided by the module
      # Note: this assumes the AMI provided is an EKS optimized AMI derivative
      enable_bootstrap_user_data = true

      instance_types = ["t3.medium"]
  }

  complete = {
      name            = "complete-eks-mng"
      use_name_prefix = true

      min_size     = 1
      max_size     = 7
      desired_size = 1

      ami_id                     = "ami-0e3758acc10746561"
      enable_bootstrap_user_data = true

      pre_bootstrap_user_data = <<-EOT
        export FOO=bar
      EOT

      post_bootstrap_user_data = <<-EOT
        echo "you are free little kubelet!"
      EOT

      capacity_type        = "SPOT"
      force_update_version = true
      instance_types       = ["t3.large", "t3.medium", "t3.small", "t3.xlarge"]
      labels = {
        GithubRepo = "terraform-aws-eks"
        GithubOrg  = "terraform-aws-modules"
      }
  }
}

aws_auth_roles = [
  {
    rolearn  = "arn:aws:iam::114712064551:role/aws-reserved/sso.amazonaws.com/eu-west-2/AWSReservedSSO_AWSAdministratorAccess_e1c02011dbc6c63b"
    username = "AWSReservedSSO_AWSAdministratorAccess_e1c02011dbc6c63b/israel.garcia"
    groups   = ["system:masters"]
  },
]

aws_auth_users = [
  {
    userarn  = "arn:aws:iam::114712064551:user/israel.garcia@verifone.com"
    username = "israel.garcia"
    groups   = ["system:masters"]
  },
]

tags = {
  Service  = "Greenbox"
  Type     = "Application"
  App_Name = "Kubernetes"
  Country  = "UK"
  Region   = "EMEA"
}