## User specific aliases and functions
alias clean="find . -maxdepth 1 -name '*~' -exec rm -v '{}' \;"
alias em="emacs"
alias ls='ls --color=auto'
alias l="ls -al --color=auto"
alias h="history"
alias hg="history | grep -i"

## tree function for systems without the 'tree' command
alias tree="find . | awk -v pwd=$PWD 'BEGIN {print pwd}                 \
                                    !/^\.$/ {for (i=1; i<NF; i++) {     \
                                                 printf(\"%4s\", \"|\") \
                                                 }                      \
                                             print \"-- \"\$NF          \
                                            }' FS='/'"

## make bash autocomplete with up arrow
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

## customize prompt with color
export PS1="\[\033[01;31m\][\d \t]\h:\w/$ \[\033[0;00m\]"
