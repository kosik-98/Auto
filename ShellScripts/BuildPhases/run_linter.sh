#!/usr/bin/env bash

eval "$($HOME/.local/bin/mise activate -C $SRCROOT bash --shims)"
mise trust

if [[ "$TARGET_NAME" == "Localization" ]]; then
    echo "Skip linting for Localization target"
    exit 0
fi

if [ -z "$(ls -A "$TARGET_NAME/Sources")" ]; then
    echo "Skip linting: nothing to lint"
    exit 0
fi

cd ${TARGET_NAME}
echo "Run SwiftLint for target $TARGET_NAME with config .swiftlint.yml"
swiftlint --config ../.swiftlint.yml
cd ..
