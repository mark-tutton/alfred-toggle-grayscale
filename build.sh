#!/bin/bash
# Packages src/ into dist/Toggle-Grayscale.alfredworkflow.
set -euo pipefail

repository_root="$(cd "$(dirname "$0")" && pwd)"
output_file="$repository_root/dist/Toggle-Grayscale.alfredworkflow"

bash -n "$repository_root/src/toggle-grayscale.sh"
mkdir -p "$repository_root/dist"
rm -f "$output_file"
(cd "$repository_root/src" && zip -qr "$output_file" . -x '.*')
echo "Built $output_file"
