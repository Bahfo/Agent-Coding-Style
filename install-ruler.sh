#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_BIN="$SCRIPT_DIR/bin"

RULER_DIR="$HOME/.ruler"
BIN_DIR="$RULER_DIR/bin"

echo "(C) COPYRIGHT 2026 EXcellent TechStacks - All Rights Reserved."
echo "================= Ruler Installation Manager ================="
echo "Installing Agent Ruler..."

mkdir -p "$BIN_DIR"

if [ ! -d "$SOURCE_BIN" ]; then
    echo "Error: Source script directory '$SOURCE_BIN' not found."
    exit 1
fi

for script in "$SOURCE_BIN"/*; do
    [ -f "$script" ] || continue
    
    filename=$(basename "$script")
    cmd_name="${filename%.sh}"
    
    cp -f "$script" "$BIN_DIR/$cmd_name"
    chmod +x "$BIN_DIR/$cmd_name"
    echo "  ✓ Installed $cmd_name"
done

SHELL_PROFILE=""
if [ -n "$ZSH_VERSION" ] || [[ "$SHELL" == *"zsh"* ]]; then
    SHELL_PROFILE="$HOME/.zshrc"
elif [ -n "$BASH_VERSION" ] || [[ "$SHELL" == *"bash"* ]]; then
    SHELL_PROFILE="$HOME/.bashrc"
else
    SHELL_PROFILE="$HOME/.profile"
fi

PATH_LINE='export PATH="$HOME/.ruler/bin:$PATH"'

if [ -f "$SHELL_PROFILE" ]; then
    if ! grep -q "$RULER_DIR/bin" "$SHELL_PROFILE"; then
        echo "" >> "$SHELL_PROFILE"
        echo "# Agent Ruler Path" >> "$SHELL_PROFILE"
        echo "$PATH_LINE" >> "$SHELL_PROFILE"
        echo "Added Agent Ruler to $SHELL_PROFILE"
    fi
fi

echo ""
echo "Agent Ruler Successfully Installed!"
echo "Binaries located at: $BIN_DIR"
echo "Run 'source $SHELL_PROFILE' or open a new terminal tab to use ruler-* commands."