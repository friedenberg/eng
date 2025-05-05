#! /bin/bash -e

PATH="$HOME/eng/zit/go/zit/build:$HOME/.dotfiles/result/bin:$HOME/eng/chrest/go/build:$PATH"

export EDITOR="$HOME/.local/bin/vim"

pushd "$HOME/workspace" >/dev/null
exec "$@"
