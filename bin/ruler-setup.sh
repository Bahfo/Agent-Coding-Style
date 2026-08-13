#!/usr/bin/env bash
set -e

RULER_PACKS="$HOME/.ruler/packs"
GLOBAL_AGENTS_DIR="$HOME/.agents"

echo "Setting up Global Agent Rules in $GLOBAL_AGENTS_DIR..."

if [ ! -d "$RULER_PACKS" ]; then
    echo "Error: ~/.ruler/packs missing. Run install-ruler.sh first."
    exit 1
fi

mkdir -p "$GLOBAL_AGENTS_DIR"
cp -r "$RULER_PACKS"/* "$GLOBAL_AGENTS_DIR/"
echo "  ✓ Synced packs into $GLOBAL_AGENTS_DIR"

GLOBAL_PROMPT_BODY=$(cat <<EOF
# GLOBAL AGENT OPERATING DIRECTIVE

> MANDATORY SYSTEM DIRECTIVE:
> You MUST recursively read, load, and follow all system rules, styles, skills, and workflows located in the user's global directory at:
> '$GLOBAL_AGENTS_DIR/'

## Global Standards
1. Read all files inside '$GLOBAL_AGENTS_DIR/' recursively before generating responses.
2. Adhere to code quality standards, memory safety rules, and workflow definitions specified in '$GLOBAL_AGENTS_DIR/'.
3. Do not add unrequested third-party dependencies or alter fundamental layouts.
EOF
)

echo "Select global setup options:"
echo " 1) OpenCode (~/.config/opencode/agents/build.md)"
echo " 2) Cursor (~/.cursor/rules/global-ruler.mdc)"
echo " 3) Claude Code (~/.claude/CLAUDE.md)"
echo " 4) All of the above (Recommended)"
read -p "Enter choice [1-4]: " CHOICE

apply_opencode() {
    mkdir -p "$HOME/.config/opencode/agents"
    cat <<EOF > "$HOME/.config/opencode/agents/build.md"
---
description: Global system rules pointer compiled by Agent Ruler
mode: primary
---

$GLOBAL_PROMPT_BODY
EOF
    echo "  ✓ OpenCode global configuration updated."
}

apply_cursor() {
    mkdir -p "$HOME/.cursor/rules"
    cat <<EOF > "$HOME/.cursor/rules/global-ruler.mdc"
---
description: Global system rules pointer compiled by Agent Ruler
alwaysApply: true
---

$GLOBAL_PROMPT_BODY
EOF
    echo "  ✓ Cursor global configuration updated."
}

apply_claude() {
    mkdir -p "$HOME/.claude"
    echo "$GLOBAL_PROMPT_BODY" > "$HOME/.claude/CLAUDE.md"
    echo "  ✓ Claude Code global configuration updated."
}

case $CHOICE in
    1) apply_opencode ;;
    2) apply_cursor ;;
    3) apply_claude ;;
    4)
        apply_opencode
        apply_cursor
        apply_claude
        ;;
    *)
        echo "Invalid selection. Exiting."
        exit 1
        ;;
esac

echo ""
echo "Global setup complete! Agents will now read $GLOBAL_AGENTS_DIR/ on every session."