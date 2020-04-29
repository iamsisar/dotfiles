#!/bin/bash
LIGHT_BLUE='\033[1;34m'
WHITE='\033[0;97m'
NONE='\033[00m'

echo -e "${LIGHT_BLUE}Install 'code-settings-sync' extension for VS Code...${NONE}"
# VS Code settings sync
code --install-extension Shan.code-settings-sync

# Check for Dropbox folder
if [[ ! -d ${HOME}/Dropbox ]]; then
    echo -e "${LIGHT_BLUE}Dropbox folder not found in your home."
    echo -e "${WHITE}Please launch the app and log to sync your Dropbox folder."
    echo -e "Press any key to exit or [Return] to continue.${NONE}"

    read -s -n 1 key

    if [[ $key != "" ]]; then
        exit
    fi
fi

# Extra dotfile for private settings
ln -s "${HOME}/Dropbox/.dotfiles/.extra" "${HOME}/.extra"

echo -e "${LIGHT_BLUE}Symlink Sublime Text 3 preferences...${NONE}"

# Sublime Text 3 packages dir symlink
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    rm -rf "${HOME}/.config/sublime-text-3/Packages/User"
    ln -s "${HOME}/Dropbox/.appdata/Sublime Text 3/Packages/User" "${HOME}/.config/sublime-text-3/Packages/User"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    rm -rf "${HOME}/Library/Application Support/Sublime Text 3/Packages/User"
    ln -s "${HOME}/Dropbox/.appdata/Sublime Text 3/Packages/User" "${HOME}/Library/Application Support/Sublime Text 3/Packages/User"
else
    echo -e "${YELLOW}Can't tell which OS is in use. Sublime Text settings not symlinked.${NONE}"
fi

source ${HOME}/.bash_profile
