#!/usr/bin/env bash

eval "$($HOME/.local/bin/mise activate -C $SRCROOT bash --shims)"
mise trust

echo "Run SwiftFormat"
swiftformat .
