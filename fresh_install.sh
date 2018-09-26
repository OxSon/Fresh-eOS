#!/usr/bin/env bash

sudo apt update
sudo apt upgrade -y

sudo apt install build-essential software-properties-common software-properties-gtk \
python-software-properties git vim-nox tmux zsh python3 -y

# Install pip3
curl https://bootstrap.pypa.io/get-pip.py | sudo python3.6

# Install NodeJS
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt update
sudo apt install -y nodejs

# Install VSCode
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt install apt-transport-https -y
sudo apt update
sudo apt install code -y

# Install tldr
sudo npm install -g tldr --allow-root --unsafe-perm=true

# Install Pure prompt for zsh
sudo npm install --global pure-prompt --allow-root --unsafe-perm=true

# Change the default shell to zsh
chsh -s $(which zsh)

# Set pure-prompt stuff in .zshrc
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME=""/g' $HOME/.zshrc
echo "# Setup pure-prompt" >> $HOME/.zshrc
echo "autoload -U promptinit; promptinit" >> $HOME/.zshrc
echo "prompt pure" >> $HOME/.zshrc

# Generate an RSA public and private key
ssh-keygen -t rsa -b 4096 -P "" -f "$HOME/.ssh/id_rsa" -q

# Install Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install zsh syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Add it to our plugins
sed -i 's/^plugins=(/plugins=(\n\tzsh-syntax-highlighting/g' $HOME/.zshrc
source $HOME/.zshrc
