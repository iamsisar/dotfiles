#!/bin/bash
BROWN='\033[0;33m'


function moveCask(){
	mv $1 /Applications
	brew cask uninstall $2
}

pinolo="wewe pinolo!"

function getCasks(){

	while read cask; do
		local dir=$(brew cask info $cask | grep '/Caskroom/' | awk '/opt/ {print $1}' | tr -d '\r')
		test -d "$dir" || continue
		local files=(${dir}/*.app)

		echo -e "\nReady to move ${cask}..."

		if [ ${#files[@]} -gt 1 ]; then
			echo -e "${BROWN}Many .app files found in ${dir}: please select which to move"

			select i in "${files[@]}" "Do nothing, I'll take care of it later"; do

				# if [ $REPLY -eq ${#files[@]} + 1 ]; then
				# 	response2="$response $cask"
				# else
				# 	moveCask "${i}"
				# fi

				echo ${#files[@]} + 1 # has to be integer!!!!

				break
			done <&1
			response=$response2
		else
			echo "just one"
			moveCask $files $cask
		fi

	done < <(brew cask list)

	echo -e ${BROWN}$response

}

getCasks

