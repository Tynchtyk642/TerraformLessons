output "instance_arn" {
    value = {for jakyp, nazim in aws_instance.jakyp : jakyp => nazim.arn}
}