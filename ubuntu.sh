#!/bin/bash

source ${HOME}/.bashrc

# Ask for the administrator password upfront
sudo -v

# Snap

sudo snap install sublime-text --classic
ln -sf "/snap/bin/subl" ${HOME}/.local/bin/subl

sudo snap install sublime-merge --classic
sudo snap install code --classic
sudo snap install docker

snap install google-chrome
rm /Applications/Google\ Chrome.app
sudo cp -R /opt/homebrew-cask/Caskroom/google-chrome/latest/Google\ Chrome.app /Applications

sudo snap install tusk
sudo snap install spotify
sudo snap install rambox

# Minimize / restore at click on dock icons
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
