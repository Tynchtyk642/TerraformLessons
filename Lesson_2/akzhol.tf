locals {
  vpc_cidr    = "10.0.0.0/16"
  subnet_cidr = "10.0.1.0/24"
  internet    = "0.0.0.0/0"
  name        = "arstan"

  ingress_rules = [
    {from_port = 80,to_port = 443, cidr_blocks = ["0.0.0.0/0"]},
    {port = 22, cidr_blocks = ["0.0.0.0/0"]},
    {port = 443, cidr_blocks = ["0.0.0.0/0"]}
  ]
}