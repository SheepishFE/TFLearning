output "ansible-instance-id" {
    value = "${aws_instance.rhel_server.id}"
}

output "ansible-instance-ip" {
    value = "${aws_instance.rhel_server.private_ip}"
}

output "ansible-instance-pip" {
    value = "${aws_instance.rhel_server.public_ip}"
}