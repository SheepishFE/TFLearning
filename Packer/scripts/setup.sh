#!/bin/bash
set -e

# Install Dependencies
# Bind Utils for DNS troubleshooting
yum update
yum install -y bind-utils

# Create ansible user, set pw and directory
sudo useradd ansible-user
sudo passwd bqSAKRh26DMy
sudo mkdir /home/ansible-user/.ssh
sudo chown -R ansible-user:ansible-user /home/ansible-user/.ssh
sudo chmod 0700 /home/ansible-user/.ssh

## add ansible user as sudoer
echo "ansible-user ALL=(ALL) NOPASSWD:ALL"



