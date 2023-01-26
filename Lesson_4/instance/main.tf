locals {
    names = {
        men = {
            type = "t2.micro"
        },
        second = {}
    }

    create_subnet = true
}

resource "aws_instance" "jakyp" {
    for_each = local.names
    instance_type = lookup(each.value, "type", "t3.medium")
    ami = data.aws_ami.ubuntu.id

    tags = {
        name = each.key
    }
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}


resource "aws_subnet" "subnets" {
    count = local.create_subnet ? 1 : 0
    
    vpc_id = aws_vpc.main.id
    cidr_block = var.cidr_block == "10.0.2.0/24" ? var.cidr_block : "10.0.1.0/24"
}