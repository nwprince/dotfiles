#!/bin/bash

ln -sv "~/.dotfiles/.zshrc" ~
ln -sv "~/.dotfiles/docker" ~/docker

sudo mkdir ~/etc/pacman.d/hooks
sudo mv "~/.dotfiles/pacman.d/mirrorupgrade.hook" ~/etc/pacman.d/hooks/
sudo pacman -Syyuu
