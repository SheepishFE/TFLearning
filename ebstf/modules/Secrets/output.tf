output "ansible-usersecret" {
  value = "${data.aws_secretsmanager_secret.ansible-user-secret.arn}"
}
