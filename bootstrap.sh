#!/usr/bin/env bash

set -Eeuo pipefail

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=scripts/lib.sh
source "$ROOT_DIR/scripts/lib.sh"
# shellcheck source=versions.env
source "$ROOT_DIR/versions.env"
# shellcheck source=scripts/install-tools.sh
source "$ROOT_DIR/scripts/install-tools.sh"
# shellcheck source=scripts/install-plugins.sh
source "$ROOT_DIR/scripts/install-plugins.sh"

DRY_RUN=0
SKIP_PACKAGES=0
SKIP_TOOLS=0
SKIP_RUNTIMES=0
SKIP_SHELL_CHANGE=0

usage() {
	cat <<'EOF'
Usage: ./bootstrap.sh [options]

Options:
  --dry-run            Show the actions without changing the machine
  --skip-packages      Do not install Ubuntu packages
  --skip-tools         Do not install Neovim, Starship, asdf or the Nerd Font
  --skip-runtimes      Do not install versions from asdf/.tool-versions
  --skip-shell-change  Do not change the login shell to Zsh
  -h, --help           Show this help
EOF
}

parse_args() {
	while (($#)); do
		case "$1" in
		--dry-run) DRY_RUN=1 ;;
		--skip-packages) SKIP_PACKAGES=1 ;;
		--skip-tools) SKIP_TOOLS=1 ;;
		--skip-runtimes) SKIP_RUNTIMES=1 ;;
		--skip-shell-change) SKIP_SHELL_CHANGE=1 ;;
		-h | --help)
			usage
			exit 0
			;;
		*) die "Unknown option: $1" ;;
		esac
		shift
	done
}

install_ubuntu_packages() {
	mapfile -t packages < <(sed -e '/^[[:space:]]*#/d' -e '/^[[:space:]]*$/d' "$ROOT_DIR/packages/ubuntu.txt")

	log "Installing ${#packages[@]} Ubuntu packages"
	run sudo apt-get update
	run sudo env DEBIAN_FRONTEND=noninteractive apt-get install -y "${packages[@]}"
}

stow_dotfiles() {
	local packages=(alacritty asdf bash nvim starship tmux wezterm zsh)

	backup_stow_conflicts
	log "Checking dotfile conflicts"
	if ((DRY_RUN)); then
		print_command stow --no --verbose=1 --dir "$ROOT_DIR" --target "$HOME" "${packages[@]}"
		print_command stow --restow --dir "$ROOT_DIR" --target "$HOME" "${packages[@]}"
		return
	fi

	if ! stow --no --verbose=1 --dir "$ROOT_DIR" --target "$HOME" "${packages[@]}"; then
		die "Stow found conflicts. Move the files above out of the way and run the bootstrap again."
	fi

	stow --restow --dir "$ROOT_DIR" --target "$HOME" "${packages[@]}"
}

backup_stow_conflicts() {
	local backup_root relative source_path destination_path resolved
	backup_root="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

	while IFS= read -r relative; do
		[[ -n "$relative" && "${relative:0:1}" != "#" ]] || continue
		source_path="$HOME/$relative"
		[[ -e "$source_path" || -L "$source_path" ]] || continue

		if [[ -L "$source_path" ]]; then
			resolved="$(readlink -f -- "$source_path" 2>/dev/null || true)"
			[[ "$resolved" == "$ROOT_DIR/"* ]] && continue
		fi

		destination_path="$backup_root/$relative"
		log "Backing up $source_path to $destination_path"
		run mkdir -p "$(dirname "$destination_path")"
		run mv -- "$source_path" "$destination_path"
	done <"$ROOT_DIR/packages/stow-targets.txt"
}

install_runtimes() {
	local name url

	export ASDF_DATA_DIR="${ASDF_DATA_DIR:-$HOME/.asdf}"
	export PATH="$HOME/.local/bin:$ASDF_DATA_DIR/shims:$PATH"

	if ((DRY_RUN)); then
		while read -r name url; do
			[[ -n "${name:-}" && "${name:0:1}" != "#" ]] || continue
			log "Would install asdf plugin: $name ($url)"
		done <"$ROOT_DIR/packages/asdf-plugins.txt"
		log "Would install runtimes from asdf/.tool-versions"
		return
	fi

	require_command asdf
	while read -r name url; do
		[[ -n "${name:-}" && "${name:0:1}" != "#" ]] || continue
		if ! asdf plugin list 2>/dev/null | grep -Fxq "$name"; then
			asdf plugin add "$name" "$url"
		fi
	done <"$ROOT_DIR/packages/asdf-plugins.txt"

	(
		cd "$ROOT_DIR/asdf"
		asdf install
	)
}

sync_neovim() {
	if ((DRY_RUN)); then
		log "Would synchronize Neovim plugins and Mason tools"
		return
	fi

	if ! command -v nvim >/dev/null 2>&1; then
		warn "Neovim is unavailable; skipping plugin synchronization"
		return
	fi

	log "Synchronizing Neovim plugins"
	nvim --headless -i NONE "+Lazy! sync" +qa
	nvim --headless -i NONE "+MasonToolsInstallSync" +qa
}

change_login_shell() {
	local zsh_path

	if ((SKIP_SHELL_CHANGE)); then
		return
	fi

	zsh_path="$(command -v zsh || true)"
	[[ -n "$zsh_path" ]] || {
		warn "Zsh is unavailable; login shell was not changed"
		return
	}

	if [[ "${SHELL:-}" == "$zsh_path" ]]; then
		log "Zsh is already the login shell"
		return
	fi

	run chsh -s "$zsh_path"
}

main() {
	parse_args "$@"
	require_ubuntu

	log "Bootstrapping dotfiles from $ROOT_DIR"
	((SKIP_PACKAGES)) || install_ubuntu_packages

	ensure_user_directories
	if ((SKIP_TOOLS == 0)); then
		install_neovim
		install_starship
		install_asdf
		install_nerd_font
	fi

	install_zsh_plugins
	install_tmux_plugins
	stow_dotfiles
	ensure_fd_alias
	((SKIP_RUNTIMES)) || install_runtimes
	sync_neovim
	change_login_shell

	log "Bootstrap complete. Start a new login session to apply shell and group changes."
}

main "$@"
