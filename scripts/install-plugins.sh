#!/usr/bin/env bash

install_zsh_plugins() {
	local custom_dir
	custom_dir="$HOME/.oh-my-zsh/custom/plugins"

	log "Installing Oh My Zsh and configured Zsh plugins"
	clone_if_missing "https://github.com/ohmyzsh/ohmyzsh.git" "$HOME/.oh-my-zsh"
	clone_if_missing "https://github.com/zsh-users/zsh-autosuggestions.git" "$custom_dir/zsh-autosuggestions"
	clone_if_missing "https://github.com/zsh-users/zsh-completions.git" "$custom_dir/zsh-completions"
	clone_if_missing "https://github.com/zsh-users/zsh-syntax-highlighting.git" "$custom_dir/zsh-syntax-highlighting"
}

install_tmux_plugins() {
	local plugin_dir
	plugin_dir="$HOME/.tmux/plugins"

	log "Installing configured tmux plugins"
	clone_if_missing "https://github.com/tmux-plugins/tpm.git" "$plugin_dir/tpm"
	clone_if_missing "https://github.com/tmux-plugins/tmux-resurrect.git" "$plugin_dir/tmux-resurrect"
	clone_if_missing "https://github.com/tmux-plugins/tmux-continuum.git" "$plugin_dir/tmux-continuum"
	clone_if_missing "https://github.com/christoomey/vim-tmux-navigator.git" "$plugin_dir/vim-tmux-navigator"
}
