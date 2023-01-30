module "vpc" {
    source = ""

    name = "jakyp"

    public_subnets = {
        first  = {
            cidr_block = "local.instance_count.0.1.0/24"
        }
        second  = {
            cidr_block = "local.instance_count.0.2.0/24"
        }
        third  = {
            cidr_block = "local.instance_count.0.3.0/24"
        }
    }
}


locals {
    instance_count = 3
}

module "machina" {
    source = "../../modules/ec2"

    instance_count = local.instance_count
    subnet_id = module.vpc.public_subnets["first"]
    # instance_type = "t3.medium"
}
