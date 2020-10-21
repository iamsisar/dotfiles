#!/bin/bash
ITERM2_SETTINGS_DIR="${HOME}/.iterm2"
ITERM2_SETTINGS_GIST="https://gist.github.com/f4fbd18392cb673ec1244cfa7d113509.git"

# iTerm2
mkdir ${ITERM2_SETTINGS_DIR}
git clone ${ITERM2_SETTINGS_GIST} ${ITERM2_SETTINGS_DIR}
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
defaults write com.googlecode.iterm2 PrefsCustomFolder -string ${ITERM2_SETTINGS_DIR}
