# Colors Palette
WHITE='\033[0;97m'
BLACK='\033[0;30m'
DARK_GREY='\033[1;30m'
BLUE="\e[1;34m"
LIGHT_BLUE='\033[1;34m'
GREEN='\033[0;32m'
LIGHT_GREEN='\033[1;32m'
CYAN='\033[0;36m'
LIGHT_CYAN='\033[1;36m'
RED='\033[0;31m'
LIGHT_RED='\033[1;31m'
PURPLE='\033[0;35m'
VIOLET='\033[1;35m'
BROWN='\033[0;33m'
YELLOW='\033[1;33m'
LIGHT_GREY='\033[0;37m'

NONE='\033[00m'


# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{variables,path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Welcome message
FORTUNE=$(fortune -s)
echo -e "\n${BROWN}${FORTUNE}${NONE}"


export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad


# PS1="${WHITE}\a\n\u@\h on \D{%a %d %b} at \A\n\[\e[m\]\w "

