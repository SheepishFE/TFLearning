# TFLearning
Used for learning Terraform and Ansible.

# AWS
Every time a new cloud playground is built, run "aws configure" to configure the CLI and enter the access/ secret key.
Region - us-east-1

# Remote State
First build the remote state S3 bucket by doing the below:
1. cd into "remote-state"
2. terraform init
3. terraform apply

# EBSTF
ebstf contains the learning infrastructure, currently it builds a VPC, Route 53 zone and 2 Instances

# Max 10 instances , or the cloud playground will be shutdown.
