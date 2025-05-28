#!/bin/bash

# Paths
ISO_NAME="shiverburn-custom.iso"
BASE_ISO="iso/base-debian.iso"
WORK_DIR="build/tmp"
OUTPUT_DIR="build/output"

# Make dirs
mkdir -p "$WORK_DIR" "$OUTPUT_DIR"

# Extract ISO
xorriso -osirrox on -indev "$BASE_ISO" -extract / "$WORK_DIR"

# Copy in preseed + ShiverBurn files
cp build/preseed.cfg "$WORK_DIR"/preseed.cfg
cp -r sbapps "$WORK_DIR"/sbapps
echo "ShiverBurn" > "$WORK_DIR"/.shiverburn-flag

# Add packages (make sure they install during preseed or first boot)
cp build/shiverburn-packages.txt "$WORK_DIR"/packages.txt

# Rebuild ISO
xorriso -as mkisofs -r -V "ShiverBurn" \
  -o "$OUTPUT_DIR/$ISO_NAME" "$WORK_DIR"

echo "✅ ISO created: $OUTPUT_DIR/$ISO_NAME"
