export PATH=~/.emacs.d/bin:$PATH
export PATH=~/.local/bin:$PATH

# VI bash mode 
set -o vi

# Exports for ranger, terminal file manager
export EDITOR=vim
export VISUAL=vim

# GOPATH
export GOPATH=$HOME/go
export PATH="$GOPATH/bin:$PATH"

# Composer
export PATH=$HOME/.config/composer/vendor/bin:$PATH

alias config='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME'
# config config --local status.showUntrackedFines no

alias ls='exa'
alias l='exa'
alias ll='exa -l'
alias la='exa -la'

colorscript random
eval "$(starship init bash)"
