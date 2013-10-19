## User specific aliases and functions
alias clean="find . -maxdepth 1 -name '*~' -exec rm -v '{}' \;"
alias em="emacs"
alias ls='ls --color=auto'
alias l="ls -al --color=auto"
alias h="history"
alias hg="history | grep -i"

## make bash autocomplete with up arrow
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

## customize prompt
export PS1="[\d \t]\h:\w/$ "

