#!/usr/bin/env bash

# (C) COPYRIGHT 2026 EXcellent TechStacks - All Rights Reserved.
# Module for removing a package from the system.

set -e

PACKAGE_NAME="$1"

if [ -z "$PACKAGE_NAME" ]; then
    echo "Usage: ruler-remove <package-name>"
    echo "Example: ruler-remove python-style"
    exit 1
fi

RULER_DIR="$HOME/.ruler"
GLOBAL_AGENTS_DIR="$HOME/.agents"
LOCAL_AGENTS_DIR=".agents"

REMOVED_ANY=0

echo "[Ruler] Searching for package '$PACKAGE_NAME'..."

TARGET_PATHS=(
    "$RULER_DIR/packs/$PACKAGE_NAME"
    "$RULER_DIR/$PACKAGE_NAME"
    "$GLOBAL_AGENTS_DIR/packs/$PACKAGE_NAME"
    "$GLOBAL_AGENTS_DIR/$PACKAGE_NAME"
)

if [ -d "$LOCAL_AGENTS_DIR" ]; then
    TARGET_PATHS+=(
        "$LOCAL_AGENTS_DIR/packs/$PACKAGE_NAME"
        "$LOCAL_AGENTS_DIR/$PACKAGE_NAME"
    )
fi

for path in "${TARGET_PATHS[@]}"; do
    if [ -d "$path" ]; then
        rm -rf "$path"
        echo "  ✓ Removed: $path"
        REMOVED_ANY=1
    fi
done

if [ "$REMOVED_ANY" -eq 1 ]; then
    echo ""
    echo "Package '$PACKAGE_NAME' successfully removed!"
else
    echo "Error: Package '$PACKAGE_NAME' not found in ~/.ruler/, ~/.agents/, or local ./.agents/"
    exit 1
fi