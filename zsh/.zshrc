# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export PATH="$HOME/.local/bin:$HOME/go/bin:$HOME/.rd/bin:$PATH"

eval "$(starship init zsh)"

. "$HOME/.asdf/asdf.sh"

plugins=(git zsh-autosuggestions)

fpath+="${ZSH_CUSTOM:-"$ZSH/custom"}/plugins/zsh-completions/src"

source "$ZSH/oh-my-zsh.sh"

# Kubernetes autocompletion
# source <(kubectl completion zsh)

alias win="cd '/mnt/c/Users/enaamtt/OneDrive - Ericsson/Downloads'"
alias work="cd ${HOME}/dev/work"
alias my="cd ${HOME}/dev/personal"

alias gm='git commit -m'

alias gp='git push'

alias gs='git status'

# alias k="minikube kubectl --"

alias k="kubectl"

alias blog="${HOME}/dev/repos/matheustanaka"

alias dotfiles="cd ${HOME}/dev/repos/dotfiles"

alias neovim="cd ${HOME}/.config/nvim/"

alias notes="cd ${HOME}/Documents/Obsidian-notes/notes"

alias v="nvim"

alias lz="lazygit"

alias tf="terraform"

alias tma="tmux attach -t"

# Ericsson Alias
alias eb23='ssh -o HostKeyAlgorithms=+ssh-rsa -o KexAlgorithms=+diffie-hellman-group14-sha1,diffie-hellman-group1-sha1 -o ServerAliveInterval=240 -o ServerAliveCountMax=2 'gu=T3650422@T3650422@ocilnx0549'@10.168.16.84'
alias eb23FQA='ssh -o HostKeyAlgorithms=+ssh-rsa -o KexAlgorithms=+diffie-hellman-group14-sha1,diffie-hellman-group1-sha1 -o ServerAliveInterval=240 -o ServerAliveCountMax=2 'gu=T3650422@sfpp@ocilnx0549'@10.168.16.84'
alias forgerock='ssh -o HostKeyAlgorithms=+ssh-rsa -o KexAlgorithms=+diffie-hellman-group14-sha1,diffie-hellman-group1-sha1 'gu=t3650422@sfpp@ocilnx0599'@10.168.16.84'
alias forgerockfqa='ssh -o HostKeyAlgorithms=+ssh-rsa -o KexAlgorithms=+diffie-hellman-group14-sha1,diffie-hellman-group1-sha1 'gu=t3650422@sfpp@ocilnx0602'@10.114.7.67'

alias onedrive='cd /mnt/c/Users/enaamtt/OneDrive - Ericsson/Downloads'

source ${HOME}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

fpath+=${ZDOTDIR:-~}/.zsh_functions

# Automatically start tmux in new terminals if not already running
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    # Create a new session called as default
    # tmux attach -t default || tmux new -s default
    # I wont use it, because I create a systemd to create a session called as main every time that I start my machine
    tmux attach -t main 
fi

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/home/mvthexz/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
#
# Kubectl autocompletion
source <(kubectl completion zsh)
