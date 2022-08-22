# TFLearning
Used for learning Terraform and Ansible.

# ACG - Pre-Req
Login to ACG (https://learn.acloud.guru/dashboard) and choose playground in the top bar:

![image](https://user-images.githubusercontent.com/27139940/185919134-7a585862-5516-4896-b18d-e1c865a2503c.png)

Grab the sandbox details:

![image](https://user-images.githubusercontent.com/27139940/185919249-4c589581-8707-4136-84e7-ed7bb80a18dd.png)

# AWS - Pre-Req
Every time a new cloud playground is built, run "aws configure" to configure the CLI and enter the access/ secret key from the above step.

Region - us-east-1

# Remote State - Pre-Req
First build the remote state S3 bucket before ebstf by doing the below:
1. cd into "remote-state"
2. delete any state files, IE **terraform.tfstate, .terraform.lock.hcl and any .terraform folders**
3. terraform init
4. terraform apply

# SSH Key - Pre-Req
Create a new ssh key on your local machine, create a new (don't get rid of existing) aws_key_pair resource with the public key details here:

/ebstf/keypair.tf

Specify the path to the private key when connecting:

ssh -i .\EC2 ec2-user@54.175.107.169 (Change public IP to whatever the instance receives)

# EBSTF
ebstf contains the learning infrastructure, currently it builds a VPC, Route 53 zone and 2 Instances.

userdata for both server contains some auto configuration, for example mounting the NFS share automatically.

# Modules
**VPC** - Sets up a basic VPC with open SSH access

**NFS Instance** Can be used as an Ansible node for testing

**Ansible Control Node Instance** - WIP

**Secrets** (not really doing anything currently)

# Max 10 instances , or the cloud playground will be shutdown.

![image](https://user-images.githubusercontent.com/27139940/185928716-54602887-a2e0-439f-9847-f72fc42a3a12.png)

