resource "aws_instance" "nazik" {
    instance_type = "t3.medium"
    ami = data.aws_ami.ubuntu.id
    subnet_id = data.terraform_remote_state.akzhol.outputs.public_subnets[1]
}

