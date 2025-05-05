#! /usr/bin/env php
<?php declare(strict_types=1);

$tz = readlink('/etc/localtime');

if (!$tz) {
  throw new RuntimeException("Failed to get current timezone");
}

$tz = substr($tz, strlen('/var/db/timezone/zoneinfo/'));

$did_set = date_default_timezone_set($tz);

if (!$did_set) {
  throw new RuntimeException("Failed to set default timezone to $tz");
}

if (count($argv) > 1) {
  $value = $argv[1];
}

if (empty($value)) {
  $value = "today";
}

$date = date_create($value);

$formats = [
  ["Week Number",    "W",                 "snippets.date.week_number"],
  ["Year Week ",     "Y-\WW",             "snippets.date.year_week"],
  ["Time Zone",      "e",                 "snippets.date.time_zone"],
  ["Unix",           "U",                 "snippets.date.unix"],
  ["File Safe Date", "Y-m-d",             "snippets.date.file_safe_date"],
  ["ISO 8601",       "c",                 "snippets.date.iso8601"],
  ["RFC 2822",       "r",                 "snippets.date.rfc2822"],
  ["RFC 3339",       \DateTime::RFC3339,  "snippets.date.rfc2822"],
];

$output = array_map(
  function ($format) use ($date) {
    $title = $format[0];
    $value = $date->format($format[1]);
    $id = $format[2];

    return [
      "title" => $title,
      "subtitle" => $value,
      "uid" => $id,
      "match" => "$title $value",
      "arg" => $value,
    ];
  },
  $formats
);

$json = json_encode(["items" => $output]);

echo($json);
