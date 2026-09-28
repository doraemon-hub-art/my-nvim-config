#!/usr/bin/env bash
# Upgrade the Neovim install at /opt/nvim-linux-x86_64 to the latest stable release.
# Usage: tools/upgrade_nvim.sh   (checks latest stable, asks before upgrading)
set -euo pipefail

INSTALL_DIR="/opt/nvim-linux-x86_64"
REPO="neovim/neovim"
ARCH="linux-x86_64"

current_version() {
  local bin="$INSTALL_DIR/bin/nvim"
  [[ -x "$bin" ]] && "$bin" --version | head -1 | grep -oP 'v[\d.]+' || echo "none"
}

# Latest stable tag (GitHub treats the non-prerelease/latest flag as stable; nightly is excluded)
latest_tag() {
  curl -fsSL "https://api.github.com/repos/$REPO/releases/latest" |
    grep -oP '(?<="tag_name": ")[^"]+'
}

latest="$(latest_tag)"
current="$(current_version)"

echo "current : $current  ($INSTALL_DIR)"
echo "latest  : $latest"

if [[ "$current" == "$latest" ]]; then
  echo "already up to date"
  exit 0
fi

read -rp "upgrade $current -> $latest ? [y/N] " ans
[[ "${ans,,}" == "y" ]] || {
  echo "aborted"
  exit 0
}

tmp="$(mktemp -d /tmp/nvim-upgrade-XXXXXX)"
trap 'rm -rf "$tmp"' EXIT

echo "downloading $latest ..."
curl -fSL --progress-bar \
  "https://github.com/$REPO/releases/download/$latest/nvim-$ARCH.tar.gz" \
  -o "$tmp/nvim.tar.gz"

tar -tzf "$tmp/nvim.tar.gz" >/dev/null || {
  echo "corrupt download"
  exit 1
}

echo "installing (needs sudo) ..."
sudo mv "$INSTALL_DIR" "$INSTALL_DIR.bak.$current" 2>/dev/null || true
if ! sudo tar -xzf "$tmp/nvim.tar.gz" -C /opt; then
  echo "extract failed, rolling back"
  sudo rm -rf "$INSTALL_DIR"
  sudo mv "$INSTALL_DIR.bak.$current" "$INSTALL_DIR"
  exit 1
fi
# tarball unpacks to nvim-linux-x86_64/, matching INSTALL_DIR
[[ "$(basename "$INSTALL_DIR")" == "nvim-$ARCH" ]] || sudo mv "/opt/nvim-$ARCH" "$INSTALL_DIR"

new="$(current_version)"
if [[ "$new" == "$latest" ]]; then
  echo "upgraded to $new (backup: $INSTALL_DIR.bak.$current)"
else
  echo "version mismatch after install: got '$new', expected '$latest'"
  echo "backup kept at $INSTALL_DIR.bak.$current"
  exit 1
fi
