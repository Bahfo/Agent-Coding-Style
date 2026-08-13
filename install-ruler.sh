#!/usr/bin/env bash
set -e

RULER_DIR="$HOME/.ruler"
BIN_DIR="$RULER_DIR/bin"

echo "(C) COPYRIGHT 2026 EXcellent TechStacks - All Rights Reserved."
echo "================= Ruler Installation Manager ================="
echo "Installing Agent Ruler..."

mkdir -p "$BIN_DIR"

COMMANDS=("ruler-init" "ruler-setup" "ruler-install" "ruler-browse" "ruler-add" "ruler-show" "ruler-remove")

for cmd in "${COMMANDS[@]}"; do
    TARGET_SCRIPT="$BIN_DIR/$cmd"
    cat <<EOF > "$TARGET_SCRIPT"
#!/usr/bin/env bash
# Agent Ruler CLI Delegate: $cmd
echo "[Ruler] Executing $cmd..."
EOF
    chmod +x "$TARGET_SCRIPT"
done

# 3. Add to User Shell Profile
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