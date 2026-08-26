#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

function k8s_context() {
    CONTEXT=$(kubectl config current-context 2>/dev/null)
    NAMESPACE=$(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)
    if [ -n "$CONTEXT" ]; then
        echo -e "$NAMESPACE"
    fi
}

export PS1="\[\033[1;34m\]\w\[\033[1;37m\] on ☸️ \[\033[1;32m\]\$(k8s_context)\[\033[0m\]\n\[\033[1;34m\]❯\[\033[1;37m\] "

export ASDF_DATA_DIR="${ASDF_DATA_DIR:-$HOME/.asdf}"
export PATH="$HOME/.local/bin:$ASDF_DATA_DIR/shims:$HOME/.rd/bin:$PATH"

[[ -r "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
[[ -r "$HOME/.bashrc.local" ]] && . "$HOME/.bashrc.local"
