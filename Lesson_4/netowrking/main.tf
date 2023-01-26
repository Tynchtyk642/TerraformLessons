locals {
  name         = "aktan-krasavchik"
  subnet_names = {
    subnet1 = {
      cidr_block = "10.0.1.0/24"
    },
    subnet2 = {
      cidr_block = "10.0.2.0/24"
    }

  }
  cidr_block   = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24", ]
}




resource "aws_vpc" "aktan" {
  cidr_block = "10.0.0.0/16"

  tags = {
    name = "vpc-${local.name}"
  }
}

resource "aws_internet_gateway" "kylych" {
    tags     = {
        "Name" = "igw-aktan-krasavchik"
    }
}

resource "aws_subnet" "subnets" {
  for_each = local.subnet_names

  vpc_id = aws_vpc.aktan.id

  cidr_block = each.value["cidr_block"]
  tags = {
    name = each.key
  }
}

resource "aws_route_table" "mintemir" {
  vpc_id = aws_vpc.aktan.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.kylych.id
  }


  tags = {
    Name = "rtb-${local.name}"
  }
}

provider "aws" {
    alias = "prod"
}

# resource "aws._route_table_association" "a" {
#     provider = aws.prod
#   count          = length(local.subnet_names)
#   subnet_id      = aws_subnet.subnets[each.key].id
#   route_table_id = aws_route_table.mintemir.id
# }

resource "aws_internet_gateway" "lunara" {
    count = terraform.workspace == "cholpon" ? 1 : 0
    tags     = {
        "Name" = "igw-aktan-krasavchik"
    }
} 