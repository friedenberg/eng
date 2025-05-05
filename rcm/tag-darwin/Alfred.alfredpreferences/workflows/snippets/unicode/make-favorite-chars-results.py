#! /usr/bin/python3

import sys
import unicodedata
import json
import alfred

chars = []

with alfred.favorites() as f:
    for char in f:
        try:
            char = alfred.Char(char)
            chars.append(char)

        except:
            print(sys.exc_info()[0])
            pass

item = {
        'title': "Search all unicode characters",
        'uid': "search-all",
        'arg': "search-all",
        }

chars.append(item)

print(json.dumps({'items': chars}))
