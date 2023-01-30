provider "aws" {
    region = "us-east-1"
    access_key = "AKIAUWBDWJ6KDMANSOH4"
    secret_key = "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"
}

terraform {
    backend "s3" {
        bucket = "flsfjdslfjdsz"
        key = "environments/stage/terraform.tfstate"
    }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.19.0"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    name = "Ulan"
    Terraform = "true"
    Environment = "dev"
  }
}

module "ec2_complete" {
  source = "../../"

  version = "4.3.0"

  name = "Tynchtyk"

  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "c5.xlarge" # used to set core count below
  availability_zone           = element(module.vpc.azs, 0)
  subnet_id                   = element(module.vpc.private_subnets, 0)
  vpc_security_group_ids      = [module.security_group.security_group_id]
  placement_group             = aws_placement_group.web.id
  associate_public_ip_address = true
  disable_api_stop            = false

  create_iam_instance_profile = true
  iam_role_description        = "IAM role for EC2 instance"
  iam_role_policies = {
    AdministratorAccess = "arn:aws:iam::aws:policy/AdministratorAccess"
  }

  # only one of these can be enabled at a time
  hibernation = true
  # enclave_options_enabled = true

  user_data_base64            = base64encode(local.user_data)
  user_data_replace_on_change = true

  cpu_core_count       = 2 # default 4
  cpu_threads_per_core = 1 # default 2

  enable_volume_tags = false
  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      throughput  = 200
      volume_size = 50
      tags = {
        Name = "my-root-block"
      }
    },
  ]

  ebs_block_device = [
    {
      device_name = "/dev/sdf"
      volume_type = "gp3"
      volume_size = 5
      throughput  = 200
      encrypted   = true
      kms_key_id  = aws_kms_key.this.arn
    }
  ]

  tags = local.tags
}
