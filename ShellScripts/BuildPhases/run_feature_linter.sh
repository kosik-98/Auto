#!/usr/bin/env bash

eval "$($HOME/.local/bin/mise activate -C $SRCROOT bash --shims)"
mise trust

if [ -z "$(ls -A "Feature/$TARGET_NAME")" ]; then
    echo "Skip linting: nothing to lint"
    exit 0
fi

cd ${TARGET_NAME}
echo "Run SwiftLint for target $TARGET_NAME with config .swiftlint.yml"
swiftlint --config ../.swiftlint.yml
cd ..
