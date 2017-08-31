# iTerm2 preference location
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "~/Dropbox/.appdata/iTerm2"

# sublimeText
rm -rf "${HOME}/Library/Application Support/Sublime Text 3/Installed Packages"
rm -rf "${HOME}/Library/Application Support/Sublime Text 3/Packages"

ln -s "${HOME}/Dropbox/.appdata/Sublime Text 3/Installed Packages" "${HOME}/Library/Application Support/Sublime Text 3/Installed Packages"
ln -s "${HOME}/Dropbox/.appdata/Sublime Text 3/Packages" "${HOME}/Library/Application Support/Sublime Text 3/Packages"

# Filezilla
for file in filters.xml sitemanager.xml filezilla.xml; do
	rm -rf "${HOME}/.filezilla/${file}"
	ln -s "${HOME}/Dropbox/.appdata/.filezilla/${file}" "${HOME}/.filezilla/${file}"
done
