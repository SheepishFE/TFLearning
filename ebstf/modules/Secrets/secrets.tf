resource "random_password" "ansible-user" {
  length            = 16
  special           = true
  override_special  = "_%@"
}

resource "aws_secretsmanager_secret" "ansible-user" {
  name = "ansible-user"
}

resource "aws_secretsmanager_secret_version" "ansible-userversion" {
  secret_id = aws_secretsmanager_secret.ansible-user.id
  secret_string = <<EOF
  {
      "username": "ansible-user",
      "password": "${random_password.ansible-user.result}"
  }
EOF
}

data "aws_secretsmanager_secret" "ansible-user-secret" {
    arn = aws_secretsmanager_secret.ansible-user.arn
}

data "aws_secretsmanager_secret_version" "ansible-userversion" {
  secret_id = data.aws_secretsmanager_secret.ansible-user-secret.arn
}