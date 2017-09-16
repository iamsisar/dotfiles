#!/bin/bash
LIGHT_BLUE='\033[1;34m'
WHITE='\033[0;97m'
NONE='\033[00m'

# Check for Dropbox folder
if [[ ! -d ${HOME}/Dropbox ]]; then
    echo -e "${LIGHT_BLUE}Dropbox folder not found in your home."
    echo -e "${WHITE}Please launch the app and log to sync your Dropbox folder."
    echo -e "Press any key to exit or [Return] to continue.${NONE}"

    read -s -n 1 key

    if [[ $key != "" ]]; then
        exit;
    fi
fi

# Extra dotfile for private settings
ln -s "${HOME}/Dropbox/.dotfiles/.extra" "${HOME}/.extra"

# iTerm2 preference location
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "~/Dropbox/.appdata/iTerm2"

# Sublime Text 3 packages dir symlink
rm -rf "${HOME}/Library/Application Support/Sublime Text 3/Installed Packages"
rm -rf "${HOME}/Library/Application Support/Sublime Text 3/Packages"
ln -s "${HOME}/Dropbox/.appdata/Sublime Text 3/Installed Packages" "${HOME}/Library/Application Support/Sublime Text 3/Installed Packages"
ln -s "${HOME}/Dropbox/.appdata/Sublime Text 3/Packages" "${HOME}/Library/Application Support/Sublime Text 3/Packages"

# Atom Code dir symlink
rm -rf "${HOME}/.atom"
ln -s "${HOME}/Dropbox/.appdata/.atom" "${HOME}/.atom"

# Visual Studio Code dir symlink
rm -rf "${HOME}/.vscode"
ln -s "${HOME}/Dropbox/.appdata/.vscode" "${HOME}/.vscode"
rm -rf "${HOME}/Library/Application Support/Code/User"
ln -s "${HOME}/Dropbox/.appdata/Code/User" "${HOME}/Library/Application Support/Code"

# Filezilla settings symlinks
for file in filters.xml sitemanager.xml filezilla.xml; do
	rm -rf "${HOME}/.filezilla/${file}"
	ln -s "${HOME}/Dropbox/.appdata/.filezilla/${file}" "${HOME}/.filezilla/${file}"
done

source ~/.bash_profile
