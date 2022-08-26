#!/bin/bash

sudo su <<EOF

set -x

#vars
ANSIBLE_INSECURE_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDhN9rP3KRPij2uIDurP0j91ffOWW2MgEubn4BLdmGER7qJ3W30mI1tSc714zhHjQrh+r98rqwNFkHqmxbU0bB1+W2fUGpAf4PGhl0zTQ/rtidqZIR0BzJvFIhuhaGLD4+XCqAOFaqm6j/MWaE+exiDs4yjQ7CNqNl3+0GC7t9IgSczYr2M63lXhrvrlKtWNfhe37FNUUa11SGtYghiTNnHwq9vMHo0LyestxSZO87eNEla+AsDOj1oj4mnEdcFLUEVsSC78/hZZUHnKP1yNdDTMN29BuA0Vtn3qJ1tdW4HgSclTREmkKKJMbJ8+uuW1dDg6hQZXQNwFvNIEDtEWCPI1XCLOf+dNlo2btF1Xw4s51TxWZPhTrIYLtnq995ENLyEsxo3la3ZQgpol4f4oQUdQR7SHqlkbKQWCeOueGSAER09p6KEtiYjyXj+xe406EEkbiluLymHrP4Ll/d1nAWw/PJC4Vs2lzfiCqpEHHJBFNAYLKdaSneD+6Vd56zC5Xk= ojcc1992@gmail.com"

# Create ansible user, set pw and directory
sudo useradd ansible-user
sudo echo "bqSAKRh26DMy" | passwd --stdin ansible-user
sudo mkdir /home/ansible-user/.ssh
sudo echo "$ANSIBLE_INSECURE_KEY" > /home/ansible-user/.ssh/authorized_keys
sudo echo "$ANSIBLE_INSECURE_KEY" > /home/ansible-user/.ssh/tf-packer.pub

#Set perms
sudo chown -R ansible-user:ansible-user /home/ansible-user/.ssh
sudo chmod 0700 /home/ansible-user/.ssh

## add ansible user as sudoer
sudo echo "ansible-user ALL=(ALL) NOPASSWD:ALL">> /etc/sudoers

EOF