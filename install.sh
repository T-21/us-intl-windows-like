#!/bin/bash

# US International Windows-like Keyboard Layout Installer
# Installs .XCompose file for smart dead key behavior

set -e

COMPOSE_FILE="$HOME/.XCompose"
BACKUP_FILE="$HOME/.XCompose.backup"

echo "================================================"
echo "US International Windows-like Layout Installer"
echo "================================================"
echo ""

REPO_FILE="$(dirname "$0")/.XCompose"

# Preserve whatever was there before we touched it. The original is kept
# once and never overwritten, so re-running this script is safe.
if [ -f "$COMPOSE_FILE" ]; then
    if [ ! -f "$BACKUP_FILE" ]; then
        echo "Existing .XCompose found, backing it up to: $BACKUP_FILE"
        cp "$COMPOSE_FILE" "$BACKUP_FILE"
    elif ! cmp -s "$COMPOSE_FILE" "$REPO_FILE"; then
        STAMP="$BACKUP_FILE.$(date +%Y%m%d-%H%M%S)"
        echo "Your .XCompose differs from this version, saving a copy at: $STAMP"
        cp "$COMPOSE_FILE" "$STAMP"
    fi
fi

# Copy our .XCompose file
echo "Installing .XCompose file..."
cp "$REPO_FILE" "$COMPOSE_FILE"

echo ""
echo "Installation complete!"
echo ""
echo "Next steps:"
echo "1. Set your keyboard layout to 'US alt. intl.' or 'US international with dead keys'"
echo "2. Log out and log back in (or restart your system)"
echo "3. Test: type 'e → é and I'm → I'm"
echo "NOTE: On Wayland, Chromium-based browsers (Chrome, Brave, Edge) may not"
echo "support .XCompose by default. See README.md for workarounds."
echo ""
echo "For more info, see: README.md"
