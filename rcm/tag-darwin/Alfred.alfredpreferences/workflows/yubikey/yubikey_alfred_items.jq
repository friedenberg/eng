#! /usr/bin/env jq --slurp -f

{
  items: [
    .[]
    | split(":")
    | {
      title: .[0],
      arg: (.[0] + ":" + .[1]),
      subtitle: .[1],
      match: (. + [(.[1] | split(" ") | join(""))] | join(" ") | ascii_downcase)
    }
  ]
}
