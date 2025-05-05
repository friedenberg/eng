#! /usr/bin/python3

import os
import sys
import json
import urllib.parse
from datetime import timedelta, datetime

import alfred
import iso8601
from babel.dates import format_timedelta

option = sys.argv[1]
connected_status = ""

if len(sys.argv) > 2:
    connected_status = sys.argv[2]

connected = connected_status == "connected"

class Device(dict):
    def __init__(self, device):
        dict.__init__(self)

        if device['connected'] == connected:
            return

        self["title"] = device["name"]

        recentAccessDate = device["recentAccessDate"]

        if recentAccessDate is not None:
            recentAccessDate = iso8601.parse_date(recentAccessDate)
            recentAccessDate = format_timedelta(
                    datetime.now() - recentAccessDate.replace(tzinfo=None),
                    locale='en_US'
                    )
            self["subtitle"] = recentAccessDate + " ago"

        self["uid"] = "bt-device." + device["address"]
        self["arg"] = device["address"]

alfred.pipeline(
        [
            "blueutil",
            f"--{option}",
            "--format=json",
            ],
        chunker = alfred.JSONChunker(Device)
        )
