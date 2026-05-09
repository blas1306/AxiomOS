#!/bin/bash

echo "Updating system..."
sudo apt update >> "$LOG_FILE" 2>&1

echo "Installing APT packages..."
for pkg in "${APT_PACKAGES[@]}"; do
    echo "Installing $pkg..."
    sudo apt install -y "$pkg" >> "$LOG_FILE" 2>&1
done