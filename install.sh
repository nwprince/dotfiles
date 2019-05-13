#!/bin/bash
USER=$(whoami)
HOSTNAME=$(hostname)
RED='\033[0;41;30m'
STD='\033[0;0;39m'

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
  mkdir -p ~/.config/Code\ -\ Insiders
  mkdir -p ~/.config/Code\ -\ Insiders/User
  sudo mkdir -p /etc/pacman.d/hooks
  # Set permissions
  ln -rsv ~/.dotfiles/docker ~/docker
  sudo setfacl -Rdm G:docker:rwx ~/docker
  sudo chmod -R 755 ~/docker
  # Create Symlinks
  sudo pacman -Syyuu
}

symlinkDots () {
  ln -sv ~/.dotfiles/.zshrc ~
  ln -sv ~/.dotfiles/.zshrc.zni ~
  ln -sv ~/.dotfiles/.gitignore ~
  ln -sv ~/.dotfiles/.gitconfig ~
  ln -sv ~/.dotfiles/vscode-insiders/settings.json ~/.config/Code\ -\ Insiders/User
  ln -rsv ~/.dotfiles/mpv ~/.config/
  ln -rsv ~/.dotfiles/sway ~/.config/
  ln -rsv ~/.dotfiles/waybar ~/.config/
  ln -rsv ~/.dotfiles/termite ~/.config/
  ln -rsv ~/.dotfiles/rofi ~/.config/
  ln -rsv ~/.dotfiles/mako ~/.config/
  ln -rsv /mnt/Television/Wallpapers ~/Pictures/
  sudo ln -sv ~/.dotfiles/pacman.d/mirrorupgrade.hook /etc/pacman.d/hooks/
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
  sudo usermod -aG docker ${USER}
  sudo echo "PUID=1000" > /etc/environment
  sudo echo "PGID=970" > /etc/environment
  sudo echo "TZ=\"America/Chicago\"" > /etc/environment
  sudo echo "USERDIR=\"/home/nwprince\"" > /etc/environment
  docker-compose -f /home/nwprince/docker/docker-compose.yml up -d
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
  echo "  1. Config github"
  echo "  2. Config ssh"
  echo "  3. Setup Dotfiles"
  echo "  4. Symlink Files"
  echo "  5. Install packages"
  echo "  6. Config docker"
  echo "  7. Install Nord Color Scheme"
  echo "  8. Exit"
  echo ""
}

read_options() {
  local choice
  read -p "Enter choice [ 1 - n ] : " choice
  case $choice in
    1) conf_git ;;
    2) conf_ssh ;;
    3) conf_dot ;;
    4) symlinkDots ;;
    5) conf_pkg ;;
    6) conf_dkr ;;
    7) conf_nrd ;;
    8) exit 0;;
    *) echo -e "${RED}Error...${STD}" && sleep 2
  esac
}

while true
do  show_menus
    read_options
done
