provider "aws" {
  access_key = "<>"
  secret_key = "<>"
  region     = "us-east-1"
}

resource "aws_instance" "anttech" {
  ami           = data.aws_ami.tayota.id
  instance_type = "t3.micro"

  tags = {
    Name   = "Nurbolot krasavchik"
    good   = "luck"
    jakshy = "okugula"
  }
}

data "aws_ami" "tayota" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}





