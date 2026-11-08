#!/usr/bin/env bash
# Rebuilds config/catppuccin-mountains.heic (maintainers only, install.sh doesn't
# run it): downloads the photo, crops it to 16:9 at 5K, recolors it with lutgen
# into Catppuccin Latte (light) and Mocha (dark), then joins both into a dynamic
# HEIC (make-dynamic-heic.swift). Needs lutgen (`brew install lutgen`) and swift.
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# "Mountains silhouetted in misty layers", Claudio Schwarz, Unsplash License:
# https://unsplash.com/photos/mountains-silhouetted-in-misty-layers-e1JXtCOsKTw
photo_url="https://images.unsplash.com/photo-1750400519626-acbef0ec0915?q=95&fm=jpg"

work="$(mktemp -d)"
trap 'rm -rf "${work}"' EXIT

curl -fsSL -o "${work}/photo.jpg" "${photo_url}"
# Full width, 16:9 height, centered (6000x4000 -> 6000x3375), then 5120x2880.
width="$(sips -g pixelWidth "${work}/photo.jpg" | awk '/pixelWidth/ {print $2}')"
sips -c "$((width * 9 / 16))" "${width}" "${work}/photo.jpg" --out "${work}/cropped.jpg" >/dev/null
sips -z 2880 5120 -s format png "${work}/cropped.jpg" --out "${work}/base.png" >/dev/null
for flavor in latte mocha; do
    lutgen apply -p "catppuccin-${flavor}" -o "${work}/${flavor}.png" "${work}/base.png" >/dev/null
done

swift "${DOT_PACKAGE_DIR}/make-dynamic-heic.swift" \
    "${work}/latte.png" "${work}/mocha.png" "${DOT_PACKAGE_DIR}/config/catppuccin-mountains.heic"
echo "built ${DOT_PACKAGE_DIR}/config/catppuccin-mountains.heic"
