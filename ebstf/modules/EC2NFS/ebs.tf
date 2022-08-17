resource "aws_ebs_volume" "tools-nfs-volume" {
    availability_zone = "us-east-1a"
    size              = 50

}

resource "aws_volume_attachment" "NFS-Attach" {
    device_name  = "/dev/xvdb"
    volume_id    = aws_ebs_volume.tools-nfs-volume.id
    instance_id  = aws_instance.rhel_server.id
    force_detach = true
}