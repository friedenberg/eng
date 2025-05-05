#! /usr/bin/python3

import os, sys
import subprocess
import urllib.parse

import alfred

from datetime import datetime

class Pass(dict):
    def __init__(self, lines):
        dict.__init__(self)

        item = lines[0]
        value = lines[1]

        self["title"] = value
        self["uid"] = f"com.pass.{item}"
        self["arg"] = item
        self["variables"] = {
                "line_number": os.environ['line_number']
                }

long_url = subprocess.run(
        ["./chrome_frontmost_url.js"],
        capture_output=True
        ).stdout

[_, netloc, _, _, _] = urllib.parse.urlsplit(long_url.decode("utf-8"))

netloc_parts = netloc.split(".")

if len(netloc_parts) > 2:
    netloc_parts = netloc_parts[-2:-1]

netloc = ".".join(netloc_parts)

alfred.pipeline(
        [
            "./pass/pass-usernames.bash",
            netloc,
            ],
        chunker = alfred.LineChunker(Pass, 2)
        )

