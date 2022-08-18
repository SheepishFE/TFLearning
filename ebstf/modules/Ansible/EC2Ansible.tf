resource "aws_instance" "rhel_server" {
    
    ami                         = var.ami_linux
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


resource "aws_route53_record" "ansible_r53_record" { 
        zone_id = "${var.private_r53}"
        name    = "ansible-TEST"
        type    = "A"
        ttl     = "300"
        records = ["${aws_instance.rhel_server.private_ip}"]
}

data "template_file" "linuxuserdata" {
    template = file("${path.module}/userdata/linux-userdata.tpl")

    vars = {
        node1_ip = "${var.nfs-instance-ip}"
    }
}