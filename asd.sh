#!/bin/bash

SOURCE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd | tr -d '\r')"

cd $SOURCE_DIR;




timestamp=$(date +%Y%m%d%H%m)

for file in .aliases .bash_profile .bash_prompt .exports .functions .gitignore_global .hgignore_global .path; do
	if [[ -f ${HOME}/$file ]]; then
		if [[ ! -d ${SOURCE_DIR}/backup_$timestamp ]]; then
			mkdir ${SOURCE_DIR}/backup_$timestamp
		fi
    	echo "Moving ${CYAN}${file} ${NONE}in ${SOURCE_DIR}/backup_${timestamp}"
		mv $HOME/$file ${SOURCE_DIR}/dotfiles_backup_${timestamp}/$file
	fi
    echo "Creating symlink to $file in $HOME ..."
    ln -sf ${SOURCE_DIR}/$file ${HOME}/$file
done
