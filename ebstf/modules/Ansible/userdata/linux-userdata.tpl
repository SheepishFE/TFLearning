#! /bin/bash

#change hostname
echo "EC2Ansible.mgmt.test.com" > /etc/hostname
hostname EC2Ansible.mgmt.test.com

#Bind Utils for DNS troubleshooting
sudo apt-get update
sudo yum install bind-utils

#SSM Agent install
yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
systemctl enable amazon-ssm-agent

#Get Role from Tags
role=$(/root/.local/bin/aws ec2 describe-tags --region us-east-1 --filters --output text "Name=resource-id,Values=$instance_id"
"Name=key,Values=Role" --query 'Tags[*].Value')

useradd ansible-user
passwd Test123!

if [[ "$role == *"nfs1"* ]]
then

    mkdir -p /ansible
    mkfs.xfs /dev/xvdb
    echo "/dev/xvdb  /ansible  xfs     defaults  0 0" >> /etc/fstab
    mount /ansible
    chown ec2-user:ec2-user /ansible
    chmod 755 /ansible

    sudo yum install ansible

    ssh-keygen
    ssh-copy-id ${node1_ip}

fi

#Create home directory on login
service oddjobd start chkconfig oddjobd on
authconfig ==enablemkhomedir --update

reboot
