output "instance_ip" {
  description = "The public ip for the instance"
  value       = aws_instance.web.public_ip
}
output "eip_ip" {
  description = "The eip ip for ssh access"
  value       = aws_eip.eip.public_ip
}

output "ssh" {
  value = "ssh -l ubuntu ${aws_eip.eip.public_ip}"
}
output "url" {
  value = "http://${aws_eip.eip.public_ip}/"
}