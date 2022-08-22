#! /bin/bash

#change hostname
echo "EC2NFS.mgmt.test.com" > /etc/hostname
hostname EC2NFS.mgmt.test.com

yum install -y firewalld
sudo systemctl enable firewalld.service
sudo systemctl start firewalld.service

#Bind Utils for DNS troubleshooting
yum update
yum install -y bind-utils

#SSM Agent install
yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
sudo systemctl enable amazon-ssm-agent
sudo systemctl start amazon-ssm-agent

sudo useradd ansible-user
sudo passwd Test123!

#Get Role from Tags
#role=$(/root/.local/bin/aws ec2 describe-tags --region us-east-1 --filters --output text "Name=resource-id,Values=$instance_id"
#"Name=key,Values=Role" --query 'Tags[*].Value')

yum install -y nfs-utils 
sudo systemctl enable nfs-server.service
sudo systemctl start nfs-server.service

#Create shared directory, give ec2-user access and share it via /etc/exports
mkdir -p /shared
mkfs.xfs /dev/nvme1n1
echo "/dev/nvme1n1  /shared  xfs     defaults  0 0" >> /etc/fstab
mount /shared
chown ec2-user:ec2-user /shared
chmod 755 /shared
echo '/shared   "*"(rw,sync,no_root_squash,no_subtree_check)' >> /etc/exports
exportfs -a

# Add FW rules for NFS
systemctl stop firewalld
firewall-offline-cmd --zone=public --add-port=111/tcp
firewall-offline-cmd --zone=public --add-port=2049/tcp
firewall-offline-cmd --list-all --zone=public
systemctl start firewalld && systemctl enable firewalld

#Create home directory on login
service oddjobd start chkconfig oddjobd on
authconfig ==enablemkhomedir --update

reboot