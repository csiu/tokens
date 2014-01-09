rename_tab () {
    TEXT=$1
    export PROMPT_COMMAND='echo -ne "\033]0;${TEXT}\007"'
}
