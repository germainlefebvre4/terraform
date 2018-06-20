output "web_private_ip" { value="${aws_instance.web.private_ip}" }
output "web_public_ip" { value="${aws_instance.web.public_ip}" }

output "web_security_group_id" { value="${aws_security_group.web.id}" }

output "alb_public_dns" { value="${aws_alb.alb.dns_name}" }

