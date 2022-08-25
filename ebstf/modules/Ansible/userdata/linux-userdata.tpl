#! /bin/bash

#change hostname
echo "EC2Ansible.mgmt.test.com" > /etc/hostname
hostname EC2Ansible.mgmt.test.com

#Bind Utils for DNS troubleshooting
yum update
yum install -y bind-utils

#SSM Agent install
yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
systemctl enable amazon-ssm-agent

#Get Role from Tags
#role=$(/root/.local/bin/aws ec2 describe-tags --region us-east-1 --filters --output text "Name=resource-id,Values=$instance_id"
#"Name=key,Values=Role" --query 'Tags[*].Value')

sudo useradd ansible-user
sudo passwd bqSAKRh26DMy
sudo mkdir /home/ansible-user/.ssh
sudo chown -R ansible-user:ansible-user /home/ansible-user/.ssh
sudo chmod 0700 /home/ansible-user/.ssh

# Create ansible data drive
mkdir -p /ansible
mkfs.xfs /dev/nvme1n1
echo "/dev/nvme1n1  /ansible  xfs     defaults  0 0" >> /etc/fstab
mount /ansible
chown ec2-user:ec2-user /ansible
chmod 755 /ansible

#Install ansible
yum install -y ansible
ansible-galaxy collection install amazon.aws

# Install nfs-utils and mount the NFS share
yum install -y nfs-utils
sudo mkdir /var/backups
chown ec2-user:ec2-user /var/backups
echo "${node1_ip}:/shared /var/backups nfs defaults 0 0">> /etc/fstab
mount /var/backups

#Create home directory on login
service oddjobd start chkconfig oddjobd on
authconfig ==enablemkhomedir --update

#Adds NFS node as a host
echo "[nfs]
${node1_ip}">>/etc/ansible/hosts

# Install git and clone the repo to get ansible playbook code
yum install -y git
git clone https://@github.com/SheepishFE/TFLearning.git /home/ansible-user/repo

reboot
