output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.main.id
}

output "instance_public_ip" {
  description = "Public IP"
  value       = aws_instance.main.public_ip
}

output "instance_private_ip" {
  description = "Private IP"
  value       = aws_instance.main.private_ip
}

output "security_group_id" {
  description = "Security group ID"
  value       = aws_security_group.ec2.id
}
