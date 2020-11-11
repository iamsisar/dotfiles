#!/bin/bash

SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd | tr -d '\r')"
TIMESTAMP=$(date +%Y%m%d%H%m)

# Make ~/.local/bin folder
if [[ ! -d ${HOME}/.local/bin/ ]]; then
  info "creating ~/.local/bin folder"
  mkdir ${HOME}/.bin/
  success "${HOME}/.local/bin/ Done"
fi

# Make ~/dev folder
if [[ ! -d ${HOME}/.bin/ ]]; then
  info "creating ~/dev folder"
  mkdir ${HOME}/dev/
  success "${HOME}/dev/ Done"
fi

# cd to dotfiles dir
cd $SOURCE_DIR

# Update
git pull origin master

# Backup old dotfiles
for file in .aliases .bashrc .bash_prompt .exports .functions .gitignore_global .path; do

  # check if file exists and if it's a symlink
  if [[ -f ${HOME}/$file && ! -L ${HOME}/$file ]]; then

    # create backup directory if not already present
    if [[ ! -d ${SOURCE_DIR}/backup_${TIMESTAMP} ]]; then
      mkdir ${SOURCE_DIR}/backup_${TIMESTAMP}
    fi

    # move old file to backup directory
    echo -e "Moving ${CYAN}${file} ${NONE}in ${SOURCE_DIR}/backup_${TIMESTAMP}"
    mv ${HOME}/$file ${SOURCE_DIR}/backup_${TIMESTAMP}/$file
  fi
done

# Symlink new dotfiles
for file in .aliases .bash_prompt .exports .functions .gitignore_global .hgignore_global .path; do
  echo -e "Creating symlink to ${SOURCE_DIR}/${CYAN}${file}${NONE} in HOME ..."
  ln -sf ${SOURCE_DIR}/$file ${HOME}/$file
done

# Print in .bashrc to source them
echo -e "Append source to .bashrc"
SOURCE_STR="\\nfor file in ~/.{variables,path,bash_prompt,exports,aliases,functions,extra,\"git-completion\"}; do [ -r \"\$file\" ] && [ -f \"\$file\" ] && source \"\$file\"\\ndone \\nunset file\\n\\n"
command printf "${SOURCE_STR}" >>"${HOME}/.bashrc"

# Git completions
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ${HOME}/.git-completion

# Git config
git config --global core.excludesfile ~/.gitignore_global
git config --global core.editor "subl -n -w"
git config --global mergetool.smerge.cmd 'smerge mergetool "$BASE" "$LOCAL" "$REMOTE" -o "$MERGED"'
git config --global mergetool.smerge.trustExitCode true
git config --global merge.tool smerge

# NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash

# Install latest version of node
nvm install node

echo -e "${PURPLE}Done! Please exec the script for your OS.${NONE}"

