# VI bash mode and completion
set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'
bind "set completion-ignore-case on"

### Exports for editors and man pages reader

export EDITOR=nvim
export VISUAL="emacsclient -c -a emacs"

export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export DENO_INSTALL="/home/ag/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

### Aliases

alias config='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias doom='~/.emacs.d/bin/doom'

alias ls='exa -al --color=always --group-directories-first'
alias la='exa -a --color=always --group-directories-first' 
alias ll='exa -l --color=always --group-directories-first' 
alias lt='exa -aT --color=always --group-directories-first'
alias l.='exa -a | egrep "^\."'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

### PATH

if [ -d "$HOME/go" ]; then
    export GOPATH=$HOME/go
    export PATH="$GOPATH/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ]; then
    export PATH=~/.local/bin:$PATH
fi

if [ -d "$HOME/.config/composer" ]; then
    export PATH=$HOME/.config/composer/vendor/bin:$PATH
fi

if [ -d "$HOME/.flutter/flutter" ]; then
    export PATH=$HOME/.flutter/flutter/bin:$PATH
fi

### Start
eval "$(starship init bash)"
fish
### . "$HOME/.cargo/env"
