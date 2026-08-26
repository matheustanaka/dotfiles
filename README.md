# Dotfiles

Reproducible Ubuntu development environment managed with GNU Stow.

## Quick start

On a fresh Ubuntu installation, install Git, clone the repository and run the
bootstrap:

```bash
sudo apt-get update
sudo apt-get install -y git
git clone https://github.com/matheustanaka/dotfiles.git "$HOME/dotfiles"
cd "$HOME/dotfiles"
./bootstrap.sh
```

The script is idempotent: it can be run again to repair links or install
anything that is missing. It supports Ubuntu on x86_64 and arm64.

## What gets installed

- Ubuntu packages from `packages/ubuntu.txt`, including Zsh, tmux, Stow,
  Alacritty, ripgrep, fd, build dependencies and clipboard integration.
- Pinned Neovim, Starship, asdf and JetBrainsMono Nerd Font releases.
- Node.js, Python, Go, Terraform, kubectl and lazygit versions from
  `asdf/.tool-versions`.
- Oh My Zsh with zsh-autosuggestions, zsh-completions and
  zsh-syntax-highlighting.
- TPM with tmux-resurrect, tmux-continuum and vim-tmux-navigator.
- Neovim plugins from `lazy-lock.json` and tools managed by Mason.

Docker and Rancher Desktop are intentionally not installed. They change
privileged system services and should be selected separately for each machine.
The shell aliases remain available when either runtime is installed.

## Bootstrap options

```text
--dry-run            Show actions without changing the machine
--skip-packages      Skip APT packages
--skip-tools         Skip Neovim, Starship, asdf and the Nerd Font
--skip-runtimes      Skip versions from asdf/.tool-versions
--skip-shell-change  Keep the current login shell
```

Inspect a fresh-machine run before applying it:

```bash
./bootstrap.sh --dry-run
```

The bootstrap never uses `stow --adopt` and never overwrites an existing
configuration. Before applying links, known conflicting files are moved to a
timestamped directory under `~/.dotfiles-backup/`. Anything unexpected still
causes Stow to stop with an error.

## Updating

External installer versions live in `versions.env`. Language and CLI versions
live in `asdf/.tool-versions`. After changing either file, run:

```bash
./bootstrap.sh
```

TPM and Zsh plugin repositories are installed once and are not updated
implicitly. Update tmux plugins with `prefix + U`; update a Zsh plugin with
`git -C ~/.oh-my-zsh/custom/plugins/<plugin> pull --ff-only`.

Machine-only environment variables and paths can be placed in
`~/.zshrc.local`. See `examples/zshrc.local`; the local file is not managed
or committed by this repository.

## Verification

```bash
./scripts/check.sh
```

This validates Bash and Zsh syntax, compiles every Lua configuration, runs
ShellCheck when available and tests all Stow packages against an empty home.
