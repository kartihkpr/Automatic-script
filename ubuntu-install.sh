#!/bin/bash

LOGFILE="install-log.txt"

log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOGFILE"
}

log_message "Starting Ubuntu installation process"

sudo apt update && sudo apt upgrade -y

sudo apt install -y \
    git \
    curl \
    wget \
    vim \
    python3 \
    python3-pip \
    docker.io \
    vlc \
    unzip \
    snapd

wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb || sudo apt --fix-broken install -y

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install -y code

sudo snap install slack --classic

wget -q https://zoom.us/client/latest/zoom_amd64.deb
sudo apt install -y ./zoom_amd64.deb

sudo apt install -y nodejs npm

wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo apt-key add -
echo "deb http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list
sudo apt update
sudo apt install -y anydesk

sudo snap install teams-for-linux

rm -f google-chrome-stable_current_amd64.deb
rm -f zoom_amd64.deb

log_message "Ubuntu installation completed"
