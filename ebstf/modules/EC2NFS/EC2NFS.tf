resource "aws_instance" "rhel_server" {
    ami                         = data.aws_ami.rhel8.id
    instance_type               = var.instance_size
    subnet_id                   = var.subnet-id
    associate_public_ip_address = true
    key_name                    = var.keypair
    availability_zone           = "us-east-1a"

    root_block_device {
      volume_size   = "${var.root_volume_size}"
    }

    vpc_security_group_ids = ["${var.securitygroupID}"]

    lifecycle {
      ignore_changes = [user_data]
    }
    user_data = "${data.template_file.linuxuserdata.rendered}"

    tags = {
      "Role" = var.servername
      "Name" = var.servername
    }

}


resource "aws_route53_record" "nfs_r53_record" { 
        zone_id = "${var.private_r53}"
        name    = "nfs-TEST"
        type    = "A"
        ttl     = "300"
        records = ["${aws_instance.rhel_server.private_ip}"]
}

data "template_file" "linuxuserdata" {
    template = file("${path.module}/userdata/linux-userdata.tpl")
}

data "aws_ami" "rhel8" {
  most_recent = true
  owners = ["self"]

  filter {
    name   = "name"
    values = "primary-ami-packer-*"
  }
}