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
sudo passwd Test123!

# Create ansible data drive
mkdir -p /ansible
mkfs.xfs /dev/nvme1n1
echo "/dev/nvme1n1  /ansible  xfs     defaults  0 0" >> /etc/fstab
mount /ansible
chown ec2-user:ec2-user /ansible
chmod 755 /ansible

#Install ansible
yum install -y ansible
systemctl enable ansible

# Install nfs-utils and mount the NFS share
yum install -y nfs-utils
sudo mkdir /var/backups
chown ec2-user:ec2-user /var/backups
echo "${node1_ip}:/shared /var/backups nfs defaults 0 0">> /etc/fstab
mount /var/backups

#Create home directory on login
service oddjobd start chkconfig oddjobd on
authconfig ==enablemkhomedir --update

reboot
