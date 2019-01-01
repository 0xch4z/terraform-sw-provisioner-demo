output "dns" {
  value = "http://${aws_instance.myec2.public_dns}/"
}
