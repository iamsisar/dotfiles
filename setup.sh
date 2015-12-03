#!/bin/bash

SOURCE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd | tr -d '\r')"

# Make ~/bin folder
if [[ ! -d $HOME/.bin/ ]] then
  info "creating local bin folder"
  mkdir $HOME/.bin/
  success "$HOME/.bin/ Done"
fi

# cd to dotfiles dir
cd $SOURCE_DIR;

# Update
git pull origin master;

# Symlink dotfiles and backup old ones if any
timestamp=$(date +%Y%m%d%H%m)
for file in .aliases .exports .functions .osx; do
	if [[ -f $file ]]; then
		if [[ ! -d ${SOURCE_DIR}/dotfiles_backup_$timestamp ]]; then
			mkdir ${SOURCE_DIR}/dotfiles_backup_$timestamp
    		echo "Moving current dotfiles in ${SOURCE_DIR}/backup_${timestamp}"
		fi
		mv $file ${SOURCE_DIR}/dotfiles_backup_${timestamp}/$file
	fi
    echo "Creating symlink to $file in $HOME ..."
    ln -sf $file $HOME/$file
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


# Setting up the sublime symlink
ln -sf "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" $HOME/bin/subl

# Organize dockbar
dockutil --remove "Contacts" --no-restart
dockutil --remove "Notes" --no-restart
dockutil --remove "Maps" --no-restart
dockutil --remove "FaceTime" --no-restart
dockutil --remove "Photo Booth" --no-restart
dockutil --remove "iBooks" --no-restart
dockutil --remove "Launchpad" --no-restart
dockutil --remove "System Preferences" --no-restart
dockutil --remove "iPhoto" --no-restart
dockutil --remove "Reminders" --no-restart
