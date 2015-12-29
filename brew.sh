#!/bin/bash

# Install command-line tools using Homebrew (if not alredy installed)
if which brew > /dev/null; then
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
fi

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# Install Homebrew formulae
brew install git
brew install node
brew install rbenv
brew install ruby-build
brew install mongodb

brew install fortune
brew install wget
brew install tree

brew install fortune
brew install imagemagick --with-webp

brew install youtube-dl
brew install dockutil


# Install Cask
brew install caskroom/cask/brew-cask

export HOMEBREW_CASK_OPTS="--appdir=/Applications"


# Install native apps
brew cask install iterm2
brew cask install sublime-text
brew cask install filezilla

brew cask install google-chrome
rm /Applications/Google\ Chrome.app
sudo cp -R /opt/homebrew-cask/Caskroom/google-chrome/latest/Google\ Chrome.app /Applications

brew cask install firefox

brew cask install dropbox
brew cask install google-drive
brew cask install skype
brew cask install evernote
brew cask install the-unarchiver

brew cask install transmission
brew cask install vlc
brew cask install spotify


