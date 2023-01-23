resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    name = "birinchi-etaj"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    "name" = "ekinchi-etaj"
  }
}
