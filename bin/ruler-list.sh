#!/usr/bin/env bash

# (C) COPYRIGHT 2026 EXcellent TechStacks - All Rights Reserved.
# Module for listing packages on the system.

set -e

PACKAGES_DIR="$HOME/.ruler/packages"

if [ ! -d "$PACKAGES_DIR" ]; then
    echo "Error: $PACKAGES_DIR directory not found. Please run installer first."
    exit 1
fi

echo "Packages found: "
echo ""
ls "$PACKAGES_DIR"