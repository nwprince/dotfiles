#!/bin/bash

ln -sv "~/.dotfiles/.zshrc" ~
ln -sv "~/.dotfiles/docker" ~/docker
mkdir ~/.ssh/config
ln -sv "~/.dotfiles/.ssh/config" ~/.ssh/confing
sudo mkdir ~/etc/pacman.d/hooks
sudo mv "~/.dotfiles/pacman.d/mirrorupgrade.hook" ~/etc/pacman.d/hooks/
sudo pacman -Syyuu
sudo pacman -S yay

#Setup ssh
ssh-keygen -t rsa -b 4096 -C "nwprince@gmail.com"
setupSSH
echo 'Paste key in Github Settings -> SSH and GPG keys -> New SSH key\n'
echo 'Github.com: https://github.com/settings/keys\n\n'
echo "SSH key: "
cat ~/.ssh/id_rsa

while IFS="" read -r p || [ -n "$p" ]
do
  yay -S --noconfirm --noanswer-edit --save $p
done < packages.txt

ln -sv "~/.dotfiles/vscode-insiders/settings.json" ~/.config/Code\ -\ Insiders/User/settings.json
