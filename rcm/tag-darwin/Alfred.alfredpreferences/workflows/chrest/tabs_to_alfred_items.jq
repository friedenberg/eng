#! /usr/bin/env -S jq -f

def make_id:
  [
    "",
    (
      [
        .id.browser.browser,
        .id.browser.id
      ] | join("-")
    ),
    (
      [
        .id.type,
        .id.id
      ] | join("-")
    )
  ] | join("/")
  ;

{
  cache: {
    seconds: 10,
    loosereload: true
  },
  items: [
    .[]
    | {
      title: .title,
      subtitle: (
        (. | make_id) + ": " + .url
      ),
      quicklook: .url,
      arg: (. | @json),
      uid: (. | make_id),
      match: (
        [
          .id.browser.browser,
          .id.browser.id,
          .id.type,
          .id.id,
          .title,
          .url
        ] | join(" ") | gsub("/"; " ")
      )
    }
  ]
}
