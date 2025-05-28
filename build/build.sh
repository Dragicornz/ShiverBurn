#!/bin/bash
set -e

DEBIAN_ISO="debian-12.5.0-amd64-netinst.iso"
ISO_URL="https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/${DEBIAN_ISO}"
WORK_DIR="build/tmp"
OUTPUT_ISO="build/output/shiverburn-installer.iso"

mkdir -p build/tmp build/output

# 1) Download the ISO if you don’t already have it locally:
if [ ! -f "${DEBIAN_ISO}" ]; then
  echo "Downloading Debian netinst ISO..."
  wget -c "${ISO_URL}"
fi

# 2) Extract ISO contents
echo "Extracting ISO..."
xorriso -osirrox on -indev "${DEBIAN_ISO}" -extract / "${WORK_DIR}"

# 3) Inject your ShiverBurn files:
echo "Copying ShiverBurn files..."
cp build/preseed.cfg "${WORK_DIR}"/preseed.cfg
cp -r sbapps "${WORK_DIR}"/sbapps
cp build/shiverburn-packages.txt "${WORK_DIR}"/packages.txt

# 4) Rebuild the customized installer ISO
echo "Rebuilding ISO..."
xorriso \
  -as mkisofs \
  -r -V "ShiverBurn Installer" \
  -o "${OUTPUT_ISO}" \
  -c isolinux/boot.cat \
  -b isolinux/isolinux.bin \
  -no-emul-boot -boot-load-size 4 -boot-info-table \
   "${WORK_DIR}"

echo "✅ Done! Your customized ISO is at ${OUTPUT_ISO}"
