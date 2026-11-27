#!/bin/bash
# Packages src/ into dist/Toggle-Grayscale.alfredworkflow.
set -euo pipefail

repository_root="$(cd "$(dirname "$0")" && pwd)"
output_file="$repository_root/dist/Toggle-Grayscale.alfredworkflow"

plutil -lint -s "$repository_root/src/info.plist"
bash -n "$repository_root/src/toggle-grayscale.sh"
if command -v shellcheck >/dev/null; then
  shellcheck "$repository_root/build.sh" "$repository_root/src/toggle-grayscale.sh"
else
  echo "shellcheck not installed, skipping" >&2
fi
mkdir -p "$repository_root/dist"
rm -f "$output_file"
(cd "$repository_root/src" && zip -qr "$output_file" . -x '.*')
echo "Built $output_file"
