[[ $- != *i* ]] && return

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY

setopt AUTO_CD

[[ -d "$HOME/.zfunc" ]] && fpath=($HOME/.zfunc $fpath)
autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

bindkey -v
bindkey -M vicmd '^l' clear-screen
bindkey -M viins '^l' clear-screen

export TERM="xterm-256color"
export EDITOR=nvim
export VISUAL="emacsclient -c -a emacs"
export MANPAGER="nvim +Man!"
export QT_QPA_PLATFORMTHEME="qt6ct"

# Cargo (Rust)
[[ -d "$HOME/.cargo" ]] && export PATH="$HOME/.cargo/bin:$PATH"

# Go
if [[ -d "$HOME/go" ]]; then
    export GOPATH="$HOME/go"
    export PATH="$GOPATH/bin:$PATH"
fi

# Local binaries
[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"

# Composer (PHP)
[[ -d "$HOME/.config/composer" ]] && export PATH="$HOME/.config/composer/vendor/bin:$PATH"

# Flutter
if [[ -d "$HOME/.flutter/flutter" ]]; then
    export PATH="$HOME/.flutter/flutter/bin:$PATH"
    export CHROME_EXECUTABLE="/usr/bin/brave"
fi

# Deno
if [[ -d "$HOME/.deno" ]]; then
    export DENO_INSTALL="$HOME/.deno"
    export PATH="$DENO_INSTALL/bin:$PATH"
fi

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
[[ ":$PATH:" != *":$PNPM_HOME:"* ]] && export PATH="$PNPM_HOME:$PATH"

# Herd Lite (PHP)
export PATH="$HOME/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="$HOME/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"

# opencode
export PATH="$HOME/.opencode/bin:$PATH"

alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

alias ls='eza -al --color=always --group-directories-first'
alias la='eza -a --color=always --group-directories-first'
alias ll='eza -l --color=always --group-directories-first'
alias lt='eza -aT --color=always --group-directories-first'
alias l.='eza -al --color=always --group-directories-first ../'
alias l..='eza -al --color=always --group-directories-first ../../'
alias l...='eza -al --color=always --group-directories-first ../../../'

alias grep='grep --color=auto'
alias cat='bat'
alias pn=pnpm
alias kubectl="minikube kubectl --"
alias v=nvim_finder
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias doom='~/.config/emacs/bin/doom'
alias assume='. assume'

nvim_finder() {
    local selection
    selection=$(fd --type f --hidden --exclude .git | fzf-tmux -p --reverse)
    [[ -n $selection ]] && nvim "$selection"
}

export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
[[ -s "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -f /usr/share/nvm/init-nvm.sh ]] && source /usr/share/nvm/init-nvm.sh

eval "$(starship init zsh)"
