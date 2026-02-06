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

# Check if .XCompose already exists
if [ -f "$COMPOSE_FILE" ]; then
    echo "⚠️  Existing .XCompose file found!"
    echo "Creating backup at: $BACKUP_FILE"
    cp "$COMPOSE_FILE" "$BACKUP_FILE"
fi

# Copy our .XCompose file
echo "📋 Installing .XCompose file..."
cp .XCompose "$COMPOSE_FILE"

echo ""
echo "✅ Installation complete!"
echo ""
echo "Next steps:"
echo "1. Set your keyboard layout to 'US alt. intl.' or 'US international with dead keys'"
echo "2. Log out and log back in (or restart your system)"
echo "3. Test: type 'e → é and I'm → I'm"
echo ""
echo "For more info, see: README.md"
