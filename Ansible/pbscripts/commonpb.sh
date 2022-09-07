if [ "$(whoami)" != "ansible-user" ]; then
        echo "Script must be run as user: username"
        exit 255
else

echo "current user is ansible-user"

chmod go-rwx ~/.ssh/tf-packer

ansible-playbook ../common.yml --key-file "~/.ssh/tf-packer"

fi