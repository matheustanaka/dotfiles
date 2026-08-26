export ZSH="$HOME/.oh-my-zsh"
export ASDF_DATA_DIR="${ASDF_DATA_DIR:-$HOME/.asdf}"
export PATH="$HOME/.local/bin:$ASDF_DATA_DIR/shims:$HOME/go/bin:$HOME/.rd/bin:/usr/local/go/bin:$PATH"
export KUBE_EDITOR=nvim

plugins=(git zsh-autosuggestions)

ZSH_COMPLETIONS_DIR="${ZSH_CUSTOM:-$ZSH/custom}/plugins/zsh-completions/src"
[[ -d "$ZSH_COMPLETIONS_DIR" ]] && fpath=("$ZSH_COMPLETIONS_DIR" $fpath)

[[ -r "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"

if command -v kubectl >/dev/null 2>&1; then
	source <(kubectl completion zsh)
fi

command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"

alias cl="clear"

alias dev="cd ${HOME}/dev/repos"

alias gm='git commit -m'

alias gp='git push'

alias gs='git status'

alias k="kubectl"

alias blog="cd ${HOME}/dev/repos/matheustanaka"

alias dotfiles="cd ${HOME}/dotfiles"

alias neovim="cd ${HOME}/.config/nvim/"

alias notes="cd ${HOME}/Documents/Obsidian-notes/notes"

alias v="nvim"

alias lz="lazygit"

alias tf="terraform"

alias dcu='docker compose up'

alias dcd='docker compose down'


fpath+=${ZDOTDIR:-~}/.zsh_functions

# Automatically start tmux in new terminals if not already running
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    # Create a new session called as default
    tmux attach -t work || tmux new -s work
    # I wont use it, because I create a systemd to create a session called as main every time that I start my machine
    # tmux attach -t main 
fi

[[ -r "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

# This plugin must be sourced after other ZLE widgets are created.
ZSH_HIGHLIGHT_FILE="${ZSH_CUSTOM:-$ZSH/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
[[ -r "$ZSH_HIGHLIGHT_FILE" ]] && source "$ZSH_HIGHLIGHT_FILE"
