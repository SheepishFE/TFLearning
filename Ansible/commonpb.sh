chmod go-rwx ~/.ssh/tf-packer

ansible-playbook ./common.yml --key-file "~/.ssh/tf-packer"