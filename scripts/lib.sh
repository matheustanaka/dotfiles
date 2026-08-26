#!/usr/bin/env bash

log() {
	printf '\033[1;34m[dotfiles]\033[0m %s\n' "$*"
}

warn() {
	printf '\033[1;33m[dotfiles]\033[0m %s\n' "$*" >&2
}

die() {
	printf '\033[1;31m[dotfiles]\033[0m %s\n' "$*" >&2
	exit 1
}

print_command() {
	printf '+ '
	printf '%q ' "$@"
	printf '\n'
}

run() {
	if ((DRY_RUN)); then
		print_command "$@"
	else
		"$@"
	fi
}

require_command() {
	command -v "$1" >/dev/null 2>&1 || die "Required command not found: $1"
}

require_ubuntu() {
	[[ -r /etc/os-release ]] || die "Cannot identify this operating system"

	# shellcheck disable=SC1091
	source /etc/os-release
	[[ "${ID:-}" == "ubuntu" ]] || die "This bootstrap currently supports Ubuntu only (found: ${ID:-unknown})"
}

machine_arch() {
	case "$(uname -m)" in
	x86_64) printf 'x86_64\n' ;;
	aarch64 | arm64) printf 'arm64\n' ;;
	*) die "Unsupported architecture: $(uname -m)" ;;
	esac
}

ensure_user_directories() {
	run mkdir -p "$HOME/.local/bin" "$HOME/.local/opt" "$HOME/.local/share/fonts"
}

download() {
	local url=$1
	local destination=$2

	log "Downloading $url"
	curl --fail --location --retry 3 --silent --show-error "$url" --output "$destination"
}

clone_if_missing() {
	local repository=$1
	local destination=$2

	if [[ -d "$destination/.git" ]]; then
		log "Already installed: $destination"
		return
	fi
	if [[ -e "$destination" ]]; then
		die "$destination exists but is not a Git checkout"
	fi

	run mkdir -p "$(dirname "$destination")"
	run git clone --depth=1 "$repository" "$destination"
}

link_binary() {
	local source_path=$1
	local target_path=$2

	if [[ -e "$target_path" && ! -L "$target_path" ]]; then
		die "Refusing to replace non-symlink: $target_path"
	fi
	run ln -sfn "$source_path" "$target_path"
}
