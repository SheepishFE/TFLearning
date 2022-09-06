output "jenkins-instance-id" {
    value = "${aws_instance.rhel_server.id}"
}

output "jenkins-instance-ip" {
    value = "${aws_instance.rhel_server.private_ip}"
}

output "jenkins-instance-pip" {
    value = "${aws_instance.rhel_server.public_ip}"
}