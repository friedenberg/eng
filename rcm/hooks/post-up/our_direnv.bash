#! /usr/bin/env -S bash -e

our_direnv="$(readlink "$HOME/.dotfiles/result/bin/direnv")"
"$our_direnv" hook fish > ~/.config/fish/direnv-config.fish
