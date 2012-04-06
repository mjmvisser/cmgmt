#
# Our aliases
#

alias setversion=". \"$ENV_SCRIPTS_DIR/setversion.sh\" \"\$@\""
alias setproject=". \"$ENV_SCRIPTS_DIR/setproject.sh\" \"\$@\""
alias go=". \"$ENV_SCRIPTS_DIR/go.sh\" \"\$@\""

#
# Other aliases
#

if [ "$OS" = "Linux" ]; then
    # only supported on linux
    alias which='alias | /usr/bin/which --tty-only -i --show-dot --show-tilde'
fi

# Command-line convenience aliases
if [ "$OS" = "Linux" ]; then
    color=--color=auto
elif [ "$OS" = "Darwin" ]; then
    color=-G
fi

alias l="/bin/ls -alh $color"
alias ll="/bin/ls -lh $color"
alias ls="/bin/ls -C $color"
alias lt="/bin/ls -lrth $color"
alias lf="/bin/ls -F $color"

unset color

alias vi='vim'
alias n='nedit'
alias g='gvim'
