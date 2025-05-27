#!/bin/bash
set -e

echo "Starting ShiverBurn ISO build..."

# Clean previous build if exists
rm -rf live-build-config
mkdir live-build-config
cd live-build-config

# Initialize a simple live build config
lb config \
    --distribution bookworm \
    --archive-areas "main contrib non-free" \
    --debian-installer false \
    --debian-installer-gui false \
    --binary-images iso-hybrid \
    --packages "lxde python3 python3-pip git" \
    --bootappend-live "boot=live components" \
    --iso-volume "ShiverBurn"

# (Optional) Add your custom files here — copy configs, scripts, wallpapers, etc.

# Build the live ISO
lb build

echo "Build finished. ISO will be at: live-build-config/live-image-amd64.hybrid.iso"
