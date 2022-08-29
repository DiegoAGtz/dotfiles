### Supresses fish's intro message
set fish_greeting

### Vi mode
function fish_user_key_bindings
  fish_vi_key_bindings
end

### Colors
set fish_color_normal brcyan
set fish_color_autosuggestion '#7d7d7d'
set fish_color_command brcyan
set fish_color_error '#ff6c6b'
set fish_color_param brcyan

### Aliases
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias doom='~/.emacs.d/bin/doom'
alias dbstart='sudo service mariadb start'
alias dbstop='sudo service mariadb stop'
alias lamp='sudo service mariadb start && sudo service apache2 start'

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

# Functions needed for !! and !$
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

# The bindings for !! and !$
if [ $fish_key_bindings = "fish_vi_key_bindings" ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

### Random color script
### colorscript random

### Chrome for flutter
### set -x CHROME_EXECUTABLE /mnt/c/Program Files/BraveSoftware/Brave-Browser/Application/brave.exe

bash "$HOME/.cargo/env"

### Starship prompt
starship init fish | source
