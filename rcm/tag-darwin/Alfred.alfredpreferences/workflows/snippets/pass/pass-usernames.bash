#! /usr/bin/env bash -e

umask "${PASSWORD_STORE_UMASK:-077}"

GPG_OPTS=( $PASSWORD_STORE_GPG_OPTS "--quiet" "--yes" "--compress-algo=none" "--no-encrypt-to" )
GPG="gpg"
export GPG_TTY="${GPG_TTY:-$(tty 2>/dev/null)}"
which gpg2 &>/dev/null && GPG="gpg2"
[[ -n $GPG_AGENT_INFO || $GPG == "gpg2" ]] && GPG_OPTS+=( "--batch" "--use-agent" )

PREFIX="${PASSWORD_STORE_DIR:-$HOME/.password-store}"

cmd_grep() {
  local passfile line

  while read -r -d "" passfile; do
    passfile="${passfile%.gpg}"
    passfile="${passfile#$PREFIX/}"

    line="$(./pass/pass-line.bash "$passfile" 2)"
    [[ -z "$line" ]] && continue

    echo "$passfile"
    echo "$line"
  done < <(find -L "$PREFIX" -path '*/.git' -prune -o -iname "$@*.gpg" -print0)
}

cmd_grep "$@"
