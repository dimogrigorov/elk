# .bashrc

# User specific aliases and functions

alias rm='echo "Use direct invocation!";'
alias cp='cp -i'
alias mv='mv -i'
alias dc='docker-compose $@'
alias vi='vim $@'
alias d='docker $@'
alias cls='tput reset'

# Git-related aliases

alias ga='git add $@'
alias gc='git commit $@'
alias gp='git push $@'
alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
