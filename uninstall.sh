#!/bin/bash

# US International Windows-like Keyboard Layout Uninstaller

set -e

COMPOSE_FILE="$HOME/.XCompose"
BACKUP_FILE="$HOME/.XCompose.backup"

echo "================================================"
echo "US International Windows-like Layout Uninstaller"
echo "================================================"
echo ""

if [ ! -f "$COMPOSE_FILE" ]; then
    echo "No .XCompose file found. Nothing to uninstall."
    exit 0
fi

# Check if backup exists
if [ -f "$BACKUP_FILE" ]; then
    echo "Restoring backup..."
    mv "$BACKUP_FILE" "$COMPOSE_FILE"
    echo "Restored previous .XCompose file"
else
    echo "Removing .XCompose file..."
    rm "$COMPOSE_FILE"
    echo "Removed .XCompose file"
fi

# Timestamped copies are left alone; only mention them so nothing is lost silently.
if ls "$BACKUP_FILE".* >/dev/null 2>&1; then
    echo ""
    echo "Additional saved copies were left in place:"
    ls -1 "$BACKUP_FILE".*
fi

echo ""
echo "Uninstallation complete!"
echo "Log out and back in for changes to take effect."
