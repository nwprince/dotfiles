#!/bin/bash
user=$(whoami)

ln -sv /home/$user/.dotfiles/.zshrc /home/$user
ln -rsv /home/$user/.dotfiles/docker /home/$user/docker
ln -sv /home/$user/.dotfiles/vscode-insiders/settings.json /home/$user/.config/Code\ -\ Insiders/User/settings.json
ln -rsv /home/$user/.dotfiles/mpv /home/$user/.config/mpv
mkdir /home/$user/.ssh/config
ln -sv /home/$user/.dotfiles/.ssh/config /home/$user/.ssh/confing
sudo mkdir /etc/pacman.d/hooks
sudo mv /home/$user/.dotfiles/pacman.d/mirrorupgrade.hook /home/$user/etc/pacman.d/hooks/
sudo pacman -Syyuu
sudo git clone https://aur.archlinux.org/yay.git /home/$user/yay
cd /home/$user/yay
makepkg -si
cd ..
sudo rm -rf /home/$user/yay

#Setup ssh
ssh-keygen -t rsa -b 4096 -C "nwprince@gmail.com"
setupSSH
echo 'Paste key in Github Settings -> SSH and GPG keys -> New SSH key\n'
echo 'Github.com: https://github.com/settings/keys\n\n'
echo "SSH key: "
cat /home/$user/.ssh/id_rsa

while IFS="" read -r p || [ -n "$p" ]
do
  yay -S --noconfirm --noanswer-edit --save $p
done < packages.txt


