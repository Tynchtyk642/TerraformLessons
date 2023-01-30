resource "aws_vpc" "aktan" {
  cidr_block = "10.0.0.0/16"

  tags = {
    name = "vpc-${var.name}"
  }
}

resource "aws_internet_gateway" "kylych" {
    vpc_id = aws_vpc.aktan.id
    tags     = {
        "Name" = "igw-aktan-krasavchik"
    }
}

resource "aws_subnet" "subnets" {
  for_each = var.public_subnets

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
    Name = "rtb-${var.name}"
  }
}
