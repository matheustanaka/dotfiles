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

alias dev="cd ${HOME}/dev/repos"

alias gm='git commit -m'

alias gp='git push'

alias gs='git status'

# alias k="minikube kubectl --"

alias k="kubectl"

alias blog="${HOME}/dev/repos/matheustanaka"

alias dotfiles="cd ${HOME}/dev/repos/dotfiles"

alias neovim="cd ${HOME}/.config/nvim/"

alias notes="cd ${HOME}/Documents/Obsidian-notes/notes"


source /home/mvthexz/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

fpath+=${ZDOTDIR:-~}/.zsh_functions

# Automatically start tmux in new terminals if not already running
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    # Create a new session called as default
    # tmux attach -t default || tmux new -s default
    # I wont use it, because I create a systemd to create a session called as main every time that I start my machine
    tmux attach -t main 
fi

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
# export PATH="/home/mvthexz/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
