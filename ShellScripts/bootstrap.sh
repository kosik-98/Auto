#!/usr/bin/env bash

S_DIR="$( cd "$( dirname "$0" )" && pwd )"
ROOT_DIR=$(dirname $S_DIR)

source $S_DIR/debug_info.sh

cd $ROOT_DIR

if [[ "${IS_CICD}" == "true" ]]; then
    print_debug_info
fi

chmod +x $S_DIR/**/*.sh

curl -fsSL https://mise.run | MISE_EXPERIMENTAL=1 sh
echo ""

echo "Activating mise..."
eval "$($HOME/.local/bin/mise activate --shims)"
echo ""

echo "Make mise config trusted"
mise trust
echo ""

mise install

echo ""
mise run setup