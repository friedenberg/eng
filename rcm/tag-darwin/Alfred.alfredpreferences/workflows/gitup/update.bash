#! /bin/bash -e

. "./bootstrap.bash"

# shellcheck disable=SC2154
cd "../lib/" || fail "Unable to cd into ../lib"

run-command() {
  TITLE="$1"
  shift

  COMMAND=("$@")
  COMMAND_STRING="${COMMAND[*]}"

  post-notification "Starting: $TITLE" "$COMMAND_STRING"

  if ! ERROR=$(../run.bash "$@" 2>&1); then
    fail "Failed: $TITLE" "$ERROR"
  fi

  post-notification "Succeeded: $TITLE" "$COMMAND_STRING"
}

if [[ -z $UPDATED ]]; then
  post-notification "Updating Alfred workflows" ""

  run-command "Pull Alfred Preferences" git pull

  UPDATED=1 exec "$0"
fi

run-command \
  "Install Python Modules" \
  /usr/bin/python3 -m pip install --user -r requirements.txt

run-command \
  "Install Brew Formulae" \
  brew bundle install

post-notification "Successfully updated Alfred workflows." ""
