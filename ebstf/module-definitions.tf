module "EC2NFS" {
    source = "./modules/EC2NFS"

    instance_size           = var.instance_size
    root_volume_size        = var.root_volume_size
    servername              = "nfs1"
    iamrole                 = aws_iam_role.nfsinstanceprofile.id
    ami_linux               = var.ami-linux
    securitygroupID         = module.VPC.securitygroupID
    disable_api_termination = "true"
    mon_to_fri_only         = "false"
    persistence             = "true"
    subnet-id               = module.VPC.subnet-id
    keypair                 = "keypair"
    private_r53             = module.VPC.private_r53
}

module "EC2Ansible" {
    source = "./modules/Ansible"

    instance_size           = var.instance_size
    root_volume_size        = var.root_volume_size
    servername              = "ansible1"
    iamrole                 = aws_iam_role.nfsinstanceprofile.id
    ami_linux               = var.ami-linux
    securitygroupID         = module.VPC.securitygroupID
    disable_api_termination = "true"
    mon_to_fri_only         = "false"
    persistence             = "true"
    subnet-id               = module.VPC.subnet-id
    keypair                 = "keypair"
    private_r53             = module.VPC.private_r53
}

module "VPC" {
    source = "./modules/VPC"

    management_vpc_cidr = var.management_vpc_cidr
}