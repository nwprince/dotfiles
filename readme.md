##Install instructions

<H1>Install instructions</H1>
1. Install yay
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
2. sudo ./install.sh
3. For Leto, run 
```bash
sudo tlp start
sudo systemctl enable tlp.service
sudo systemctl enable tlp-sleep.service
sudo systemctl mask systemd-rfkill.service
```
