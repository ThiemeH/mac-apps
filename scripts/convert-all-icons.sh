#!/bin/bash

for APP in "/Applications"/*.app; do
    APP_NAME=$(basename "$APP" .app)
    ICNS_FILE=$(find "$APP" -name '*.icns' -print -quit)
    if [ -n "$ICNS_FILE" ]; then
        ./generate-icon.sh "$ICNS_FILE"
    fi
done

echo "Conversion of all icons complete."
