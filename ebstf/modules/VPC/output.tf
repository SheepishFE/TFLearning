output "subnet-id" {
  value = aws_subnet.public_subnet.id
}
output "securitygroupID" {
  value = aws_security_group.nfs-sg.id
}

output "private_r53" {
  value = aws_route53_zone.private_mgmt.zone_id
}