#!/bin/bash

# Install command-line tools using Homebrew (if not alredy installed)
if ! which brew >/dev/null; then
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Add Homebrew to PATH
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
echo 'eval $('${HOMEBREW_PREFIX}'/bin/brew shellenv)' >>${HOME}/.bashrc

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# Install Homebrew formulae

brew install fortune
brew install tree
brew install thefuck
