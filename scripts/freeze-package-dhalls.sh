#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR=$(cd "$(dirname "$0")/.."; pwd -P)

find "$ROOT_DIR/deps" -name '*.dhall' | xargs -n 1 dhall freeze --cache --all --inplace

# The order is important because they depend on each other.
# A tree would be ideal, but it is bash ¯\_(ツ)_/¯
# TODO: Automatically figure this out
package_files=(Source/package.dhall
               InParams/package.dhall
               OutParams/package.dhall
               package.dhall
              )

for f in "${package_files[@]}"; do
    echo "Freezing $f"
    dhall freeze --cache --all --inplace "$ROOT_DIR/$f"
done
