#!/bin/bash
USER=$(whoami)
HOSTNAME=$(hostname)
RED='\033[0;41;30m'
STD='\033[0;0;39m'

conf_all() {
  conf_ssh
  conf_dot
  symlinkDots
  conf_pkg
  conf_dkr
  conf_proj
  conf_notes
  conf_nrd
}

conf_ssh() {
  mkdir ~/.ssh
  mkdir ~/.ssh/config
  ln -sv ~/.dotfiles/.ssh/config ~/.ssh/confing
  ssh-keygen -t rsa -b 4096 -C "nwprince@gmail.com"
  setupSSH
  echo 'Paste key in Github Settings -> SSH and GPG keys -> New SSH key\n'
  echo 'Github.com: https://github.com/settings/keys\n\n'
  echo "SSH key: "
  cat /home/$user/.ssh/id_rsa
}

conf_dot() {
  # Make directories
  mkdir -p ~/.config
  mkdir -p ~/.config/VSCodium
  mkdir -p ~/.config/VSCodium/User
  mkdir -p ~/.config/sway
  sudo mkdir -p /etc/pacman.d/hooks
  # Set permissions
  ln -rsv ~/.dotfiles/docker ~/docker
  sudo chmod -R 755 ~/docker
  # Create Symlinks
  sudo pacman -Syyuu
}

symlinkDots () {
  ln -sv ~/.dotfiles/.zshrc ~
  ln -sv ~/.dotfiles/.zshrc.zni ~
  ln -sv ~/.dotfiles/.gitignore ~
  ln -sv ~/.dotfiles/.gitconfig ~
  ln -sv ~/.dotfiles/VSCodium/User/settings.json ~/.config/VSCodium/User/settings.json
  ln -rsv ~/.dotfiles/mpv ~/.config/
  ln -rsv ~/.dotfiles/sway ~/.config/
  ln -rsv ~/.dotfiles/waybar ~/.config/
  ln -rsv ~/.dotfiles/termite ~/.config/
  ln -rsv ~/.dotfiles/kitty ~/.config/
  ln -rsv ~/.dotfiles/rofi ~/.config/
  ln -rsv ~/.dotfiles/mako ~/.config/
  ln -rsv /mnt/Television/Wallpapers ~/Pictures/
  case $HOSTNAME in
    artemis) conf_sway_desktop ;;
    leto) conf_sway_laptop ;;
  esac
  ln -sv ~/.dotfiles/sway/config ~/.config/sway/config
  sudo ln -sv ~/.dotfiles/pacman.d/mirrorupgrade.hook /etc/pacman.d/hooks/
  sudo rm /etc/environment
  sudo ln -sv ~/.dotfiles/etc/environment /etc/environment
}

conf_sway_desktop() {
  touch ~/.dotfiles/sway/config
  cat ~/.dotfiles/sway/config_base > config
  cat ~/.dotfiles/sway/config_desktop >> config
}

conf_sway_laptop() {
  touch ~/.dotfiles/sway/config
  cat ~/.dotfiles/sway/config_base > config
  cat ~/.dotfiles/sway/config_laptop >> config
}

conf_pkg() {
  #sudo pacman -Syyuu
  install_txt_list "common.txt"
  case $HOSTNAME in
    artemis) install_txt_list "artemis.txt" ;;
    leto) install_txt_list "leto.txt" ;;
  esac
}

install_txt_list() {
  while IFS="" read -r p || [ -n "$p" ]
  do
    yay -S --noconfirm  --save $p
  done < packages/$1
}

conf_dkr() {
  sudo systemctl enable docker.service
  sudo systemctl start docker.service
  sudo systemctl enable emby-server.service
  sudo systemctl start emby-server.service
  sudo usermod -aG docker ${USER}
  sudo setfacl -Rdm g:docker:rwx ~/docker
  sudo docker-compose -f /home/nwprince/docker/docker-compose.yml up -d
}

conf_proj() {
  mkdir ~/Projects
  mkdir ~/Projects/Go
  mkdir ~/Projects/Android
  mkdir ~/Projects/Open_Source
}

conf_notes() {
  git clone https://github.com/nwprince/notes ~/.notable
}

conf_nrd() {
  git clone https://github.com/arcticicestudio/nord-gnome-terminal.git /tmp/Nord
  cd /tmp/Nord/src
  ./nord.sh
  cd ~/.dotfiles
}

show_menus() {
  clear
  echo "  ~~~~~~~~~~~~~~~~~~~~~"
  echo "  ~~~~~~INSTALLER~~~~~~"
  echo "  ~~~~~~~~~~~~~~~~~~~~~"
  echo "  1. Run All"
  echo "  2. Config ssh"
  echo "  3. Setup Dotfiles"
  echo "  4. Symlink Files"
  echo "  5. Install packages"
  echo "  6. Config docker"
  echo "  7. Setup Projects"
  echo "  8. Setup Notes"
  echo "  9. Install Nord Color Scheme"
  echo "  10. Exit"
  echo ""
}

read_options() {
  local choice
  read -p "Enter choice [ 1 - n ] : " choice
  case $choice in
    1) conf_all ;;
    2) conf_ssh ;;
    3) conf_dot ;;
    4) symlinkDots ;;
    5) conf_pkg ;;
    6) conf_dkr ;;
    7) conf_proj ;;
    8) conf_notes ;;
    9) conf_nrd ;;
    10) exit 0;;
    *) echo -e "${RED}Error...${STD}" && sleep 2
  esac
}

while true
do  show_menus
    read_options
done
