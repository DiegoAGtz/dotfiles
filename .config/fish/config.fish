### EXPORT ###
set fish_greeting                                 # Supresses fish's intro message
set EDITOR "nvim"                                 # $EDITOR use Emacs in terminal

set -e COLUMNS
set -e LINES

### RANDOM COLOR SCRIPT ###
colorscript random

### SETTING THE STARSHIP PROMPT ###
starship init fish | source

alias config='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME'
alias ls='exa'
alias l='exa'
alias ll='exa -l'
alias la='exa -la'
