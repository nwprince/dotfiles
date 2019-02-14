#!/bin/bash
USER=$(whoami)
HOSTNAME=$(hostname)
RED='\033[0;41;30m'
STD='\033[0;0;39m'

conf_git() {
  git config --global user.email "nwprince@gmail.com"
  git config --global user.name "nwprince"
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
  mkdir ~/docker
  mkdir ~/.config
  mkdir ~/.config/Code\ -\ Insiders
  mkdir ~/.config/Code\ -\ Insiders/User
  mkdir ~/.config/mpv
  sudo mkdir /etc/pacman.d/hooks

  # Set permissions
  sudo setfacl -Rdm G:docker:rwx ~/docker
  sudo chmod -R 755 ~/docker

  # Create Symlinks
  ln -sv ~/.dotfiles/.zshrc ~
  ln -rsv ~/.dotfiles/docker ~/docker
  ln -sv ~/.dotfiles/vscode-insiders/settings.json ~/.config/Code\ -\ Insiders/User/settings.json
  ln -rsv ~/.dotfiles/mpv ~/.config/mpv
  sudo ln -sv ~/.dotfiles/pacman.d/mirrorupgrade.hook /etc/pacman.d/hooks/
  sudo pacman -Syyuu
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
  echo "PUID=1000" > /etc/environment
  echo "PGID=970" > /etc/environment
  echo "TZ=\"America/Chicago\""
  echo "USERDIR=\"/home/nwprince\""
  docker-compose -f ~/docker/docker-compose.yml up -d
}

show_menus() {
  clear
	echo "  ~~~~~~~~~~~~~~~~~~~~~"
	echo "  ~~~~~~INSTALLER~~~~~~"
	echo "  ~~~~~~~~~~~~~~~~~~~~~"
	echo "  1. Config github"
	echo "  2. Config ssh"
	echo "  3. Install Dotfiles"
  echo "  4. Install packages"
  echo "  5. Config docker"
  echo "  6. Exit"
  echo ""
}

read_options() {
  local choice
  read -p "Enter choice [ 1 - n ] : " choice
  case $choice in
    1) conf_git ;;
    2) conf_ssh ;;
    3) conf_dot ;;
    4) conf_pkg ;;
    5) conf_dkr ;;
    6) exit 0;;
    *) echo -e "${RED}Error...${STD}" && sleep 2
  esac
}

while true
do  show_menus
    read_options
done