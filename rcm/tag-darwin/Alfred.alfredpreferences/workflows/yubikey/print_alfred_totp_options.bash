#! /bin/bash -xe

ykman oath accounts list \
  | cut -d: -f1,2 \
  | tr \\n \\0 \
  | xargs -0 -L1 printf '"%s"\n' \
  | "$(dirname "$0")/yubikey_alfred_items.jq"
