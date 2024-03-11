#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 [APPLICATION_NAME]"
    exit 1
fi

APPLICATION_NAME="$1"

# Perform fuzzy search to find the best match among application names
BEST_MATCH=$(ls /Applications | grep -i "$APPLICATION_NAME" | sort -u | fzf --prompt="Select an application: " --layout=reverse --height=50% --border)

if [ -z "$BEST_MATCH" ]; then
    echo "No matching application found."
    exit 1
fi

APP_PATH="/Applications/$BEST_MATCH/Contents/Resources"
ICNS_FILE=$(find "$APP_PATH" -name '*.icns' | fzf --prompt="Select a file: " --layout=reverse --height=50% --border)

if [ -z "$ICNS_FILE" ]; then
    echo "No file selected."
    exit 1
fi

./generate-icon.sh "$ICNS_FILE"
echo "Conversion complete."
