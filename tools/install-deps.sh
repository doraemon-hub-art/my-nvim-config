#!/usr/bin/env bash
# Install the system packages this nvim config needs (Debian/Ubuntu).
# Packages mason.nvim installs itself (clangd, lua-language-server, pyright,
# rust-analyzer, vtsls, stylua, shfmt, prettier, tree-sitter) are NOT listed here.
# node/npm (used by mason for pyright/prettier/vtsls) and rustfmt (rustup) are
# also expected to come from their own installers.
#
# Usage: tools/install-deps.sh [--check]
#   --check  only report what is missing, install nothing (exit 1 if anything is)
set -euo pipefail

PACKAGES=(
	# lazy.nvim / mason / nvim-treesitter: clone, download, unpack
	git
	curl
	wget
	tar
	gzip
	unzip
	# make + cc: telescope-fzf-native build, treesitter parser compile
	build-essential
	# rg: telescope live_grep
	ripgrep
	# fdfind: telescope find_files fallback order fd -> fdfind -> find
	fd-find
	# conform.nvim: C/C++ formatting
	clang-format
	# clipboard provider for 'clipboard=unnamedplus': wl-copy on Wayland, xclip on X11
	wl-clipboard
	xclip
)

usage() {
	sed -n '2,9p' "$0" | sed 's/^# \{0,1\}//'
}

check_only=0
case "${1:-}" in
	--check) check_only=1 ;;
	-h | --help)
		usage
		exit 0
		;;
	"") ;;
	*)
		usage >&2
		exit 2
		;;
esac

if ! command -v apt-get >/dev/null; then
	echo "Error: only apt (Debian/Ubuntu) is supported" >&2
	exit 1
fi

missing=()
for pkg in "${PACKAGES[@]}"; do
	dpkg -s "$pkg" >/dev/null 2>&1 || missing+=("$pkg")
done

if [ "${#missing[@]}" -eq 0 ]; then
	echo "all ${#PACKAGES[@]} packages already installed"
	exit 0
fi

echo "missing (${#missing[@]}/${#PACKAGES[@]}): ${missing[*]}"
if [ "$check_only" -eq 1 ]; then
	echo "would run: sudo apt-get update && sudo apt-get install -y ${missing[*]}"
	exit 1
fi

sudo apt-get update
sudo apt-get install -y "${missing[@]}"
echo "installed: ${missing[*]}"
