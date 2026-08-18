#!/usr/bin/env bash
#/**
# * @file format-lua.sh
# * @author Hermes (auto-generated)
# * @brief Format all Lua config files under lua/ with stylua
# * @date 2026-08-17
# *
# * @copyright Copyright (c) 2026
# */

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
STYLUA="${HOME}/.local/share/nvim-next/mason/bin/stylua"

# Fallback: try PATH
if [ ! -x "$STYLUA" ]; then
    STYLUA="$(command -v stylua 2>/dev/null || true)"
fi

if [ -z "$STYLUA" ]; then
    echo "Error: stylua not found (install via Mason or add to PATH)" >&2
    exit 1
fi

CONFIG="${SCRIPT_DIR}/custom_config/stylua.toml"

cd "$SCRIPT_DIR"
echo "format lua/ ..."
"$STYLUA" --config-path "$CONFIG" lua/
echo "done"
