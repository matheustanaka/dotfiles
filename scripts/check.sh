#!/usr/bin/env bash

set -Eeuo pipefail

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
TEMP_HOME="$(mktemp -d)"
trap 'rm -rf "$TEMP_HOME"' EXIT

bash -n "$ROOT_DIR/bootstrap.sh"
bash -n "$ROOT_DIR/scripts/lib.sh"
bash -n "$ROOT_DIR/scripts/install-tools.sh"
bash -n "$ROOT_DIR/scripts/install-plugins.sh"
bash -n "$ROOT_DIR/bash/.bashrc"
zsh -n "$ROOT_DIR/zsh/.zshrc"

if command -v shellcheck >/dev/null 2>&1; then
	shellcheck --external-sources \
		"$ROOT_DIR/bootstrap.sh" \
		"$ROOT_DIR/scripts/check.sh"
fi

if command -v nvim >/dev/null 2>&1; then
	nvim --headless -u NONE -i NONE \
		-c "lua for _, file in ipairs(vim.fn.glob('$ROOT_DIR/nvim/.config/nvim/**/*.lua', false, true)) do assert(loadfile(file)) end" \
		-c qa
fi

stow --no --verbose=1 \
	--dir "$ROOT_DIR" \
	--target "$TEMP_HOME" \
	alacritty asdf bash nvim starship tmux wezterm zsh

printf 'All checks passed.\n'
