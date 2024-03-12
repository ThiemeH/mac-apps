#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 [PATH_TO_FILE]"
    exit 1
fi

INPUT_FILE="$1"
OUTPUT_DIR="../generated"
RESIZE_DIMENSION=80

if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: $INPUT_FILE not found."
    exit 1
fi

if [ ! -d "$OUTPUT_DIR" ]; then
    mkdir -p "$OUTPUT_DIR"
fi

# Check if INPUT_FILE path contains a .app and extract application name
APP_NAME=""
if [[ "$INPUT_FILE" == *".app"* ]]; then
    APP_PATH=$(echo "$INPUT_FILE" | grep -o '.*/[^/]*\.app')
    APP_NAME=$(basename "$APP_PATH" ".app")
fi

FILE_NAME=$(basename "$INPUT_FILE")
FILE_NAME="${FILE_NAME%.*}"

if [ ! -z "$APP_NAME" ]; then
    FILE_NAME="$APP_NAME"
fi

OUTPUT_FILE="$OUTPUT_DIR"/"$FILE_NAME".png

sips -s format png "$INPUT_FILE" --out "$OUTPUT_FILE"
convert "$OUTPUT_FILE" -resize ${RESIZE_DIMENSION}x${RESIZE_DIMENSION} "$OUTPUT_FILE"
NEW_NAME=$(echo "$FILE_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
mv "$OUTPUT_FILE" "$OUTPUT_DIR"/"$NEW_NAME".png

echo "Conversion complete. PNG file saved as $OUTPUT_DIR/$NEW_NAME.png"
