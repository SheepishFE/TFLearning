output "subnet-id" {
  value = aws_subnet.public_subnet.id
}
output "securitygroupID" {
  value = aws_security_group.nfs-sg.id
}

output "private_r53" {
  value = aws_route53_zone.private_mgmt.zone_id
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}