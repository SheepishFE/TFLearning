#! /bin/bash

#change hostname
echo "EC2Jenkins.mgmt.test.com" > /etc/hostname
hostname EC2Jenkins.mgmt.test.com

# Bind Utils for DNS troubleshooting
sudo yum update
sudo yum install -y bind-utils

#SSM Agent install
yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
systemctl enable amazon-ssm-agent

#Get Role from Tags
#role=$(/root/.local/bin/aws ec2 describe-tags --region us-east-1 --filters --output text "Name=resource-id,Values=$instance_id"
#"Name=key,Values=Role" --query 'Tags[*].Value')

# Install nfs-utils and mount the NFS share
yum install -y nfs-utils
sudo mkdir /var/jenkins
chown ec2-user:ec2-user /var/jenkins
echo "${nfs_ip}:/shared /var/jenkins nfs defaults 0 0">> /etc/fstab
mount /var/jenkins

#Create home directory on login
service oddjobd start chkconfig oddjobd on
authconfig ==enablemkhomedir --update

yum install -y git
git clone https://@github.com/SheepishFE/TFLearning.git /var/jenkins/repo
chown -R ec2-user:ec2-user /var/jenkins/repo
chmod 755 /var/jenkins/repo

reboot