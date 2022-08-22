# TFLearning
Used for learning Terraform and Ansible.

# AWS - Pre-Req
Every time a new cloud playground is built, run "aws configure" to configure the CLI and enter the access/ secret key.
Region - us-east-1

# Remote State - Pre-Req
First build the remote state S3 bucket by doing the below:
1. cd into "remote-state"
2. terraform init
3. terraform apply

# SSH Key - Pre-Req
Create a new ssh key on your local machine, create a new aws_key_pair resource with the public key details here (don't get rid of existing)
main/ebstf/keypair.tf

Specify the path to the private key when connecting:
ssh -i .\EC2 ec2-user@54.175.107.169

# EBSTF
ebstf contains the learning infrastructure, currently it builds a VPC, Route 53 zone and 2 Instances.

userdata for both server contains some auto configuration, for example mounting the NFS share automatically.

# Modules
**VPC** - Sets up a basic VPC with open SSH access

**NFS Instance** Can be used as an Ansible node for testing

**Ansible Control** Node Instance - WIP

**Secrets** (not really doing anything currently)

# Max 10 instances , or the cloud playground will be shutdown.
