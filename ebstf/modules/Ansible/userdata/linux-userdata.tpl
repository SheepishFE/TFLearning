#! /bin/bash

#change hostname
echo "EC2Ansible.mgmt.test.com" > /etc/hostname
hostname EC2Ansible.mgmt.test.com

# Bind Utils for DNS troubleshooting
sudo yum update
sudo yum install -y bind-utils

#Install awscli
sudo yum install -y awscli

#SSM Agent install
yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
systemctl enable amazon-ssm-agent

#Get Role from Tags
#role=$(/root/.local/bin/aws ec2 describe-tags --region us-east-1 --filters --output text "Name=resource-id,Values=$instance_id"
#"Name=key,Values=Role" --query 'Tags[*].Value')

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
echo "${nfs_ip}:/shared /var/backups nfs defaults 0 0">> /etc/fstab
mount /var/backups

#Create home directory on login
service oddjobd start chkconfig oddjobd on
authconfig ==enablemkhomedir --update

#Adds NFS node as a host
echo "[nfs]
${nfs_ip}">>/etc/ansible/hosts

#Adds jenkins node as a host
echo "[jenkins]
${jenkins_ip}">>/etc/ansible/hosts

#Add ALL hosts here for generic 
echo "[servers]
${nfs_ip}
${jenkins_ip}
localhost">>/etc/ansible/hosts

# Install git and clone the repo to get ansible playbook code
yum install -y git
git clone https://@github.com/SheepishFE/TFLearning.git /home/ansible-user/repo
chown -R ansible-user:ansible-user /home/ansible-user/repo
chmod 755 /home/ansible-user/repo

#populate known hosts
ssh-keyscan -H "${nfs_ip}" >> /home/ansible-user/.ssh/known_hosts
ssh-keyscan -H "${jenkins_ip}" >> /home/ansible-user/.ssh/known_hosts
chown -R ansible-user:ansible-user /home/ansible-user/.ssh/
chmod 755 /home/ansible-user/.ssh/

reboot
