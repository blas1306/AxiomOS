#!/bin/bash

echo "Installing PIP packages..."
for pkg in "${PIP_PACKAGES[@]}"; do
    echo "Installing $pkg..."
    python3 -m pip install --user "$pkg" >> "$LOG_FILE" 2>&1
done