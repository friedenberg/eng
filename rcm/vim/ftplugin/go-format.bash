#! /usr/bin/env bash

PATH="$(realpath "$(dirname "$(readlink "$0")")/result/bin"):$PATH"

cmd_gofmt="gofmt"

if command -v gofumpt >/dev/null; then
  cmd_gofmt="gofumpt"
fi

in="$1"

out="$(mktemp)"
trap "rm '$out'" EXIT

err="$(mktemp)"
trap "rm '$err'" EXIT

if ! goimports "$in" >"$out" 2>"$err"; then
  cat "$err" >&2
  exit 1
fi

out1="$(mktemp)"
trap "rm '$out1'" EXIT

cmd_golines=(
  golines
  --no-chain-split-dots
  --shorten-comments
  -m 80
)

if ! "${cmd_golines[@]}" <"$out" >"$out1" 2>"$err"; then
  cat "$err" >&2
  exit 1
fi

out2="$(mktemp)"
trap "rm '$out1'" EXIT

if ! $cmd_gofmt -s -e "$out1" >"$out2" 2>"$err"; then
  sed "s:<standard input>:$in:g" <"$err" >&2
  exit 1
fi

# TODO-P2 add go-fix

cat "$out2"
