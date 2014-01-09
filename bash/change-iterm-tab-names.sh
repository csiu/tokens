rename_tab () {
    TEXT=$@
    export PROMPT_COMMAND='echo -ne "\033]0;${TEXT}\007"'
}
