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

# Filezilla settings symlinks
for file in filters.xml sitemanager.xml filezilla.xml; do
	rm -rf "${HOME}/.filezilla/${file}"
	ln -s "${HOME}/Dropbox/.appdata/.filezilla/${file}" "${HOME}/.filezilla/${file}"
done
