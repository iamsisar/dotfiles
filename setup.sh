#!/bin/bash

SOURCE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd | tr -d '\r')"
TIMESTAMP=$(date +%Y%m%d%H%m)

# Make ~/.bin folder
if [[ ! -d ${HOME}/.bin/ ]]; then
  info "creating ~/.bin folder"
  mkdir ${HOME}/.bin/
  success "${HOME}/.bin/ Done"
fi

# Make ~/dev folder
if [[ ! -d ${HOME}/.bin/ ]]; then
  info "creating ~/dev folder"
  mkdir ${HOME}/dev/
  success "${HOME}/dev/ Done"
fi

# cd to dotfiles dir
cd $SOURCE_DIR;

# Update
git pull origin master;

# Symlink dotfiles and backup old ones if any
for file in .aliases .bash_profile .bash_prompt .exports .functions .gitignore_global .hgignore_global .path; do

    # check if file exists and if it's a symlink
    if [[ -f ${HOME}/$file && ! -h ${HOME}/$file ]]; then

        # create backup directory if not already present
        if [[ ! -d ${SOURCE_DIR}/backup_${TIMESTAMP} ]]; then
            mkdir ${SOURCE_DIR}/backup_${TIMESTAMP}
        fi

        # move old file to backup directory
        echo -e "Moving ${CYAN}${file} ${NONE}in ${SOURCE_DIR}/backup_${TIMESTAMP}"
        mv ${HOME}/$file ${SOURCE_DIR}/backup_${TIMESTAMP}/$file
    fi

	# link new file
    echo -e "Creating symlink to ${SOURCE_DIR}/${CYAN}${file}${NONE} in HOME ..."
    ln -sf ${SOURCE_DIR}/$file ${HOME}/$file
done


# Enable
source ${HOME}/.bash_profile

# Install Xcode
xcode-select --install

# Install Ruby
echo -e "${LIGHT_BLUE}Installing Ruby and Bundler..."
rbenv install 2.2.3
rbenv global 2.2.3
which ruby
gem update --system

gem install bundler
rbenv rehash

# Install PHP
echo -e "${LIGHT_BLUE}Installing Apache and PHP..."
brew tap homebrew/dupes
brew tap homebrew/versions
brew tap homebrew/php
brew tap homebrew/apache

sudo apachectl stop
sudo launchctl unload -w /System/Library/LaunchDaemons/org.apache.httpd.plist 2>/dev/null
brew install httpd24 --with-privileged-ports --with-http2

sudo cp -v "$(brew list httpd24 | head -1 | sed 's/\(^.*\/httpd24\/[^\/]*\).*/\1/')"/homebrew.mxcl.httpd24.plist /Library/LaunchDaemons
sudo chown -v root:wheel /Library/LaunchDaemons/homebrew.mxcl.httpd24.plist
sudo chmod -v 644 /Library/LaunchDaemons/homebrew.mxcl.httpd24.plist
sudo launchctl load /Library/LaunchDaemons/homebrew.mxcl.httpd24.plist

brew install php56 --with-httpd24

# Install MySql
echo -e "${LIGHT_BLUE}Installing MySql..."
brew install mysql
mysql.server start
mysql_secure_installation
ln -sfv /usr/local/opt/mysql/*.plist ${HOME}/Library/LaunchAgents 
launchctl load ${HOME}/Library/LaunchAgents/homebrew.mxcl.mysql.plist

# Node packages
sudo -v
npm install -g grunt-cli
npm install -g gulp
npm install -g bower
npm install -g browser-sync

# Git completions
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ${HOME}/.git-completion

# Git global ignore
git config --global core.excludesfile ~/.gitignore_global