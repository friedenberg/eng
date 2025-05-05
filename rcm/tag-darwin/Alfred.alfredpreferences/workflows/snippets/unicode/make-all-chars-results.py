#! /usr/bin/python3

import sys
import unicodedata
import json
import alfred

chars = []

for c in range(0, 0x10FFFF + 1):
    try:
        char = alfred.Char(c)
        chars.append(char)

    except ValueError as e:
        pass

print(json.dumps({'items': chars}))
