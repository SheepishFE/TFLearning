output "nfs-instance-id" {
    value = "${aws_instance.rhel_server.id}"
}

output "nfs-instance-ip" {
    value = "${aws_instance.rhel_server.private_ip}"
}