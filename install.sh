#!/bin/bash

# Update and upgrade system packages
apt update && apt upgrade -y

# Install required packages: nload (network monitoring) and autossh (automatic SSH management)
apt install -y nload autossh 

# Create an SSH directory if it doesn't exist
mkdir -p ~/.ssh

# Add a public SSH key to the authorized_keys file for secure access
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDetYRskkjsKdUYwcIZ9njpIvd+Yd59gsiG/AvQDqI4uYAIWOiX7S20pZb51Fvj21WefcdeD6wjvXwevo1vWWT0V51lcxwEJH5XPzYHQv5LoGn7+n5BkNLCcStNjikGuHPmf4XHmwbw5fABTZhtRDzyfBO8pz1mX5ZgplCfw20v4MxMp+REMGQiKtCcWVrlG/i1+0BlxMpSJG9kKlrN8wVEVP0TZHCIRaejW2sMMFKkKbwjGwzfstTlw2Qnun30ZHE6LY3qJg1YfpadIa7gOtcpWSzQpp/+KyQH8yFGXvNkr1itY2em3fUvF6AdqdQ8szjBHP+rjQwLgh+lyD5jAK+0mWAoZmiYgUJO+nFW0DrNGUz4JHwek3NgwzOQ2nm2K9MVTm8jc8fulH6ghvdw9dipB62+FQFazQkQONwPzaNIEb0I1xdrPtOX7GGMkg/VJ8Del/TbxrA4pS69purK5iLZMZzKqIjj2Ukp+1/6hIW5DWuXW43YcayFDqY5/vk+uKE=' >> ~/.ssh/authorized_keys

# Fetch additional SSH keys from GitHub and append them to the authorized_keys file
curl https://github.com/samsesh.keys >> ~/.ssh/authorized_keys
curl https://github.com/royalhaze.keys >> ~/.ssh/authorized_keys

# Run a remote setup script directly from a URL
curl https://raw.githubusercontent.com/malkemit/namizun/master/else/setup.sh | bash

# Copy a custom SSH server configuration file to its default location
cp ./sshd_config /etc/ssh/sshd_config

# Set the server's timezone to Asia/Tehran
timedatectl set-timezone Asia/Tehran

# Restart the SSH daemon to apply configuration changes
systemctl restart sshd
systemctl restart ssh
