#! /bin/bash

#change hostname
echo "EC2NFS.mgmt.test.com" > /etc/hostname
hostname EC2NFS.mgmt.test.com

#Bind Utils for DNS troubleshooting
sudo apt-get update
sudo yum install bind-utils

#SSM Agent install
yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
systemctl enable amazon-ssm-agent

#Get Role from Tags
role=$(/root/.local/bin/aws ec2 describe-tags --region us-east-1 --filters --output text "Name=resource-id,Values=$instance_id"
"Name=key,Values=Role" --query 'Tags[*].Value')

if [[ "$role == *"nfs1"* ]]
then

    yum -y install nfs-utils 
    systemctl enable nfs-server.service
    systemctl start nfs-server.service

    mkdir -p /shared
    mkfs.xfs /dev/xvdb
    echo "/dev/xvdb  /shared  xfs     defaults  0 0" >> /etc/fstab
    mount /shared
    chown ec2-user:ec2-user /shared
    chmod 755 /shared
    echo '/shared   "*"(rw,sync,no_root_squash.no_subtree_check)' >> /etc/exports
    exportfs -a
fi

#Create home directory on login
service oddjobd start chkconfig oddjobd on
authconfig ==enablemkhomedir --update

reboot