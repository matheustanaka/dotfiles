#!/usr/bin/env bash

install_neovim() {
	local arch asset install_dir temp_dir
	arch="$(machine_arch)"
	asset="nvim-linux-$arch"
	install_dir="$HOME/.local/opt/nvim-$NEOVIM_VERSION"

	if [[ ! -x "$install_dir/$asset/bin/nvim" ]]; then
		if ((DRY_RUN)); then
			log "Would install Neovim $NEOVIM_VERSION for $arch"
		else
			temp_dir="$(mktemp -d)"
			download "https://github.com/neovim/neovim/releases/download/$NEOVIM_VERSION/$asset.tar.gz" "$temp_dir/$asset.tar.gz"
			download "https://github.com/neovim/neovim/releases/download/$NEOVIM_VERSION/shasum.txt" "$temp_dir/shasum.txt"
			(cd "$temp_dir" && sha256sum --check --ignore-missing shasum.txt)
			mkdir -p "$install_dir"
			tar -xzf "$temp_dir/$asset.tar.gz" -C "$install_dir"
			rm -rf "$temp_dir"
		fi
	else
		log "Neovim $NEOVIM_VERSION is already installed"
	fi

	link_binary "$install_dir/$asset/bin/nvim" "$HOME/.local/bin/nvim"
}

install_starship() {
	local arch target archive_arch temp_dir
	arch="$(machine_arch)"
	case "$arch" in
		x86_64) archive_arch="x86_64-unknown-linux-gnu" ;;
		arm64) archive_arch="aarch64-unknown-linux-gnu" ;;
	esac
	target="$HOME/.local/opt/starship-$STARSHIP_VERSION/starship"

	if [[ ! -x "$target" ]]; then
		if ((DRY_RUN)); then
			log "Would install Starship $STARSHIP_VERSION for $arch"
		else
			temp_dir="$(mktemp -d)"
			download "https://github.com/starship/starship/releases/download/$STARSHIP_VERSION/starship-$archive_arch.tar.gz" "$temp_dir/starship.tar.gz"
			mkdir -p "$(dirname "$target")"
			tar -xzf "$temp_dir/starship.tar.gz" -C "$(dirname "$target")" starship
			chmod +x "$target"
			rm -rf "$temp_dir"
		fi
	else
		log "Starship $STARSHIP_VERSION is already installed"
	fi

	link_binary "$target" "$HOME/.local/bin/starship"
}

install_asdf() {
	local arch asset target temp_dir
	arch="$(machine_arch)"
	case "$arch" in
		x86_64) asset="linux-amd64" ;;
		arm64) asset="linux-arm64" ;;
	esac
	target="$HOME/.local/opt/asdf-$ASDF_VERSION/asdf"

	if [[ ! -x "$target" ]]; then
		if ((DRY_RUN)); then
			log "Would install asdf $ASDF_VERSION for $arch"
		else
			temp_dir="$(mktemp -d)"
			download "https://github.com/asdf-vm/asdf/releases/download/$ASDF_VERSION/asdf-$ASDF_VERSION-$asset.tar.gz" "$temp_dir/asdf.tar.gz"
			mkdir -p "$(dirname "$target")"
			tar -xzf "$temp_dir/asdf.tar.gz" -C "$(dirname "$target")" asdf
			chmod +x "$target"
			rm -rf "$temp_dir"
		fi
	else
		log "asdf $ASDF_VERSION is already installed"
	fi

	link_binary "$target" "$HOME/.local/bin/asdf"
}

install_nerd_font() {
	local destination temp_dir
	destination="$HOME/.local/share/fonts/JetBrainsMonoNerdFont-$NERD_FONT_VERSION"

	if [[ -d "$destination" ]]; then
		log "JetBrainsMono Nerd Font $NERD_FONT_VERSION is already installed"
		return
	fi
	if ((DRY_RUN)); then
		log "Would install JetBrainsMono Nerd Font $NERD_FONT_VERSION"
		return
	fi

	temp_dir="$(mktemp -d)"
	download "https://github.com/ryanoasis/nerd-fonts/releases/download/$NERD_FONT_VERSION/JetBrainsMono.tar.xz" "$temp_dir/JetBrainsMono.tar.xz"
	mkdir -p "$destination"
	tar -xJf "$temp_dir/JetBrainsMono.tar.xz" -C "$destination"
	fc-cache -f "$destination"
	rm -rf "$temp_dir"
}

ensure_fd_alias() {
	if command -v fd >/dev/null 2>&1; then
		return
	fi
	if command -v fdfind >/dev/null 2>&1; then
		link_binary "$(command -v fdfind)" "$HOME/.local/bin/fd"
	fi
}
