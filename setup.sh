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

	# check for old dotfiles
	if [[ -f ~/$file && ! -h ~/$file ]]; then

		# create backup directory if necessary
		if [[ ! -d ${SOURCE_DIR}/backup_${TIMESTAMP} ]]; then
			mkdir ${SOURCE_DIR}/backup_${TIMESTAMP}
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


# Install Ruby
echo -e "${LIGHT_BLUE}Installing Ruby and Bundler..."
rbenv install 2.2.3
rbenv global 2.2.3
which ruby
gem update --system

gem install bundler
rbenv rehash

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

