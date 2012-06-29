alias la='ls -Al'
alias gc='git commit'
alias gs='git status -s'
alias ga='git add'
alias gd='git diff'
alias g='git'

GRAY='\[\e[0;37m\]'
BLUE='\e[1;34m'
GOLD='\[\e[0;33m\]'
CYAN='\[\e[1;36m\]'
GREEN='\[\e[0;32m\]'
RED='\[\e[1;31m\]'
YELLOW='\[\e[1;33m\]'
WHITE='\e[1;37m'

export HISTIGNORE="&:ls:[bf]g:exit"

# Change to the last accessed directory
if [ -f ~/.lastdir ]; then
	cd "`cat ~/.lastdir`"
fi

export LASTDIR="/"
function prompt_command() {
	newdir=`pwd`

	if [ ! "${LASTDIR}" = "${newdir}" ]; then
		# Remember the new directory
		pwd > ~/.lastdir

		if [ -d ./.git ]; then
			# Show git status if the new dir is a repository
			git status
		else
			# Show 7 most receently accessed files
			ls -Alt | head -7 | sort
		fi
	fi

	export LASTDIR=$newdir
}
#return value visualisation
PROMPT_COMMAND='RET=$?;'
RET_VALUE='$(if [[ $RET = 0 ]]; then echo -ne "${GREEN} ${RET}"; else echo -ne "${RED} ${RET}"; fi;) '
export PROMPT_COMMAND="${PROMPT_COMMAND} prompt_command;"
RED='\e[0;31m'
GREEN='\e[0;32m'
PS1="${GRAY}[\$(date +%H:%M)]"                    # Current time
PS1="${PS1}${RET_VALUE}"                          # Last Exit code
PS1="${PS1}${CYAN}\u"                             # Username
PS1="${PS1}${GRAY}@"                              # @
PS1="${PS1}${CYAN}\h "                            # Hostname
PS1="${PS1}${GRAY}in "                            # in
PS1="${PS1}${WHITE}\w "                           # Working directory
PS1="${PS1}${YELLOW}\$(__git_ps1)\n"
PS1="${PS1}${GRAY}$ "
export PS1