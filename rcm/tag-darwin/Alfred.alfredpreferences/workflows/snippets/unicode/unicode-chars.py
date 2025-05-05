#! /usr/bin/python3

import sys
import unicodedata
import json

query = sys.argv[1].lower()

chars = []
for c in range(0, 0x10FFFF + 1):
    try:
        original = c
        c = chr(c)

        name = unicodedata.name(c)

        matches = [
                name,
                c,
                str(original),
                hex(ord(c)),
                hex(ord(c))[2:-1],
                ]

        joined = " ".join(matches).lower()

        if query not in joined:
            continue

        item = {
                'title': c,
                'subtitle': name,
                'uid': "unicode." + str(original),
                'match': joined,
                'arg': c,
                }

        chars.append(item)

    except ValueError:
        pass

print(json.dumps({'items': chars}))
