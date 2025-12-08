output "website_url" {
  description = "HTTP URL for the one-pager."
  value       = "http://${aws_instance.web.public_ip}"
}

output "instance_public_ip" {
  description = "Public IPv4 address of the EC2 instance."
  value       = aws_instance.web.public_ip
}

output "instance_id" {
  description = "EC2 instance ID."
  value       = aws_instance.web.id
}

output "subnet_id" {
  description = "Public subnet ID."
  value       = aws_subnet.public.id
}
