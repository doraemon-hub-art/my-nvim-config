#!/usr/bin/env bash
# Upgrade the kitty install at ~/.local/kitty.app to the latest stable release.
# Usage: tools/upgrade_kitty.sh   (checks latest stable, asks before upgrading)
set -euo pipefail

APP_DIR="$HOME/.local/kitty.app"
BIN_DIR="$HOME/.local/bin"
REPO="kovidgoyal/kitty"
ARCH="x86_64"

current_version() {
  local bin="$APP_DIR/bin/kitty"
  [[ -x "$bin" ]] && "$bin" --version | grep -oP '[\d.]+' | head -1 || echo "none"
}

# Latest stable tag from GitHub (nightly is a prerelease, excluded by /latest)
latest_tag() {
  curl -fsSL "https://api.github.com/repos/$REPO/releases/latest" |
    grep -oP '(?<="tag_name": ")[^"]+'
}

latest="$(latest_tag)"
current="$(current_version)"

echo "current : $current  ($APP_DIR)"
echo "latest  : $latest"

if [[ "v$current" == "$latest" ]]; then
  echo "already up to date"
  exit 0
fi

read -rp "upgrade $current -> $latest ? [y/N] " ans
[[ "${ans,,}" == "y" ]] || {
  echo "aborted"
  exit 0
}

tmp="$(mktemp -d /tmp/kitty-upgrade-XXXXXX)"
trap 'rm -rf "$tmp"' EXIT

txz="kitty-${latest#v}-$ARCH.txz"
echo "downloading $txz ..."
curl -fSL --progress-bar \
  "https://github.com/$REPO/releases/download/$latest/$txz" \
  -o "$tmp/kitty.txz"

xz -t "$tmp/kitty.txz" || {
  echo "corrupt download"
  exit 1
}

echo "installing ..."
[[ -d "$APP_DIR" ]] && mv "$APP_DIR" "$APP_DIR.bak.v$current"
# txz unpacks to bin/ lib/ share/ directly (no kitty.app/ wrapper)
mkdir -p "$tmp/kitty.app"
tar -xf "$tmp/kitty.txz" -C "$tmp/kitty.app"
mv "$tmp/kitty.app" "$APP_DIR"
mkdir -p "$BIN_DIR"
ln -sf "$APP_DIR/bin/kitty" "$BIN_DIR/kitty"

new="$(current_version)"
if [[ "v$new" == "$latest" ]]; then
  echo "upgraded to $new (backup: $APP_DIR.bak.v$current)"
  hash -r 2>/dev/null || true
else
  echo "version mismatch after install: got '$new', expected '$latest'"
  echo "backup kept at $APP_DIR.bak.v$current"
  exit 1
fi
