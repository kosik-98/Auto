#!/usr/bin/env bash

eval "$($HOME/.local/bin/mise activate -C $SRCROOT bash --shims)"
mise trust

rm -rf ${TARGET_NAME}/Sources/Generated
mkdir -p ${TARGET_NAME}/Sources/Generated

echo "Run code generation"

swiftgen config run --config ${TARGET_NAME}/swiftgen.yml