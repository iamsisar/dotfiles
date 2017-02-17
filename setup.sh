#!/bin/bash

SOURCE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd | tr -d '\r')"
TIMESTAMP=$(date +%Y%m%d%H%m)

# Make ~/.bin folder
if [[ ! -d $HOME/.bin/ ]]; then
  info "creating local bin folder"
  mkdir $HOME/.bin/
  success "$HOME/.bin/ Done"
fi

# cd to dotfiles dir
cd $SOURCE_DIR;

# Update
git pull origin master;



# Symlink dotfiles and backup old ones if any

for file in .aliases .bash_profile .bash_prompt .exports .functions .gitignore_global .hgignore_global .path; do


		# create backup directory if necessary
		if [[ ! -d ${SOURCE_DIR}/backup_${TIMESTAMP} ]]; then
		fi

		# move old files
    	echo -e "Moving ${CYAN}${file} ${NONE}in ${SOURCE_DIR}/backup_${TIMESTAMP}"
		mv ~/$file ${SOURCE_DIR}/backup_${TIMESTAMP}/$file
	fi

	# link new files
    echo -e "Creating symlink to ${SOURCE_DIR}/${CYAN}${file}${NONE} in HOME ..."
    ln -sf ${SOURCE_DIR}/$file ~/$file
done


# Enable
source ~/.bash_profile

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
ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents 
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist

# Node packages
sudo -v
npm install -g grunt-cli
npm install -g gulp
npm install -g bower
npm install -g browser-sync


# Setting up the sublime symlink
ln -sf "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" $HOME/.bin/subl

# Add git completions
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion
