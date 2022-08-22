
variable "ami-linux" {
  description = "AMI"
}

variable "root_volume_size" {
  description = "rootvol"
}

variable "instance_size" {
  description = "instancesize"
}

variable "interface_name" {
  description = "interfacetype"
}

variable "aws_region" {
  description = "AWS region to launch servers"
}

variable "keypair" {
  description = "Keypair"
}

variable "management_vpc_cidr" {
  description = "CIDR block of the Management VPC for "
}

//variable "private_r53" {
//  description = "private r53 zone"
//}

//variable "subnet_id" {
 // description = "public subnet ID"
//}
