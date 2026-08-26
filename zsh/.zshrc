# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# Setup Rust Cargo
#. "$HOME/.cargo/env" 
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export PATH="$HOME/.local/bin:$HOME/go/bin:$HOME/.rd/bin:$PATH:/usr/local/go/bin"
export KUBE_EDITOR=vim
export TERM=xterm-256color


eval "$(starship init zsh)"

. "$HOME/.asdf/asdf.sh"

plugins=(git zsh-autosuggestions)

fpath+="${ZSH_CUSTOM:-"$ZSH/custom"}/plugins/zsh-completions/src"

source "$ZSH/oh-my-zsh.sh"

# Kubernetes autocompletion
source <(kubectl completion zsh)

alias cl="clear"

alias dev="cd ${HOME}/dev/repos"

alias gm='git commit -m'

alias gp='git push'

alias gs='git status'

alias k="kubectl"

alias blog="${HOME}/dev/repos/matheustanaka"

alias dotfiles="cd ${HOME}/dotfiles"

alias neovim="cd ${HOME}/.config/nvim/"

alias notes="cd ${HOME}/Documents/Obsidian-notes/notes"

alias v="nvim"

alias lz="lazygit"

alias tf="terraform"

alias dcu='docker compose up'

alias dcd='docker compose down'


source "${HOME}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

fpath+=${ZDOTDIR:-~}/.zsh_functions

# Automatically start tmux in new terminals if not already running
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    # Create a new session called as default
    tmux attach -t work || tmux new -s work
    # I wont use it, because I create a systemd to create a session called as main every time that I start my machine
    # tmux attach -t main 
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
