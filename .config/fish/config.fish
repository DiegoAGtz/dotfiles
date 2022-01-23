### EXPORT ###
set fish_greeting                                 # Supresses fish's intro message
set EDITOR "nvim"                                 # $EDITOR use Emacs in terminal

set -e COLUMNS
set -e LINES

### RANDOM COLOR SCRIPT ###
colorscript random

### SETTING THE STARSHIP PROMPT ###
starship init fish | source

set GOPATH ~/go
fish_add_path $GOPATH/bin

alias config='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME'
alias doom='~/.emacs.d/bin/doom'
alias ls='exa'
alias l='exa'
alias ll='exa -l'
alias la='exa -la'
