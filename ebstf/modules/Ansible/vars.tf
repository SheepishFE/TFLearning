# Declare variables. Values passed through from script calling module
variable "servername" {}
variable "iamrole" {}
variable "root_volume_size" {}
variable "keypair" {}
variable "subnet-id" {}

variable "securitygroupID" {}

variable "ami_linux" {}
variable "instance_size" {}
variable "persistence" {}
variable "mon_to_fri_only" {}
variable "disable_api_termination" {}
variable "private_r53" {}
variable "nfs-instance-ip" {}