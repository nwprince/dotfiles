#!/bin/bash
user=$(whoami)

ln -sv ~/.dotfiles/.zshrc ~
ln -rsv ~/.dotfiles/docker ~/docker
mkdir ~/.config
mkdir ~/.config/Code\ -\ Insiders
mkdir ~/.config/Code\ -\ Insiders/User
ln -sv ~/.dotfiles/vscode-insiders/settings.json ~/.config/Code\ -\ Insiders/User/settings.json
mkdir ~/.config/mpv
ln -rsv ~/.dotfiles/mpv ~/.config/mpv
mkdir ~/.ssh
mkdir ~/.ssh/config
ln -sv ~/.dotfiles/.ssh/config ~/.ssh/confing
sudo mkdir /etc/pacman.d/hooks
sudo ln -sv ~/.dotfiles/pacman.d/mirrorupgrade.hook /etc/pacman.d/hooks/
sudo pacman -Syyuu

#Setup ssh
ssh-keygen -t rsa -b 4096 -C "nwprince@gmail.com"
setupSSH
echo 'Paste key in Github Settings -> SSH and GPG keys -> New SSH key\n'
echo 'Github.com: https://github.com/settings/keys\n\n'
echo "SSH key: "
cat /home/$user/.ssh/id_rsa

while IFS="" read -r p || [ -n "$p" ]
do
  yay -S --noconfirm  --save $p
done < packages.txt


