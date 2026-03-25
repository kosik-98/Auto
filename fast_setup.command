#!/usr/bin/env bash
cd "$( dirname "$0" )"
eval "$($HOME/.local/bin/mise activate bash --shims)" || true

if hash mise 2>/dev/null; then
    mise trust
    mise run fast-setup
else
    sh "$( cd "$( dirname "$0" )" && pwd )"/ShellScripts/bootstrap.sh
fi