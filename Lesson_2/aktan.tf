resource "aws_vpc" "main" {
  cidr_block = local.vpc_cidr
  tags       = {}
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw-${local.name}"
  }
}


resource "aws_route_table" "example" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = local.internet
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "change"
  }

  # lifecycle {
  #   # ignore_changes = [tags["Name"]]
  # }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.example.id
}

resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = local.subnet_cidr

  tags = {
    name = "subnet-${local.name}"
  }
}


resource "aws_security_group" "sg" {
  name        = "cjdsjflsdj"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = local.ingress_rules
    content {
      from_port   = ingress.value["from_port"]
      to_port     = ingress.value["to_port"]
      protocol    = "tcp"
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [local.internet]
  }

  tags = {
    Name = "sg-${local.name}"
  }

  lifecycle {
    create_before_destroy = true
  }
}
