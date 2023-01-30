resource "aws_instance" "jakyp" {
    count = var.instance_count
    instance_type = var.instance_type
    ami = data.aws_ami.ubuntu.id
    subnet_id = var.subnet_id

    tags = {
        name = "module-instance"
    }
}