#! /usr/bin/python3

import contextlib
import json
import os
import pickle
import sys
import unicodedata

class Char(dict):
    def __init__(self, c):
        dict.__init__(self)

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

        self["title"] = c
        self["subtitle"] = name
        self["uid"] = "unicode." + str(original)
        self["match"] = joined
        self["arg"] = c

@contextlib.contextmanager
def favorites():
    path = os.path.join(
            os.path.dirname(__file__),
            "build",
            "favorite-chars.pickle"
            )

    try:
        with open(path, 'rb') as f:
            fav_chars = pickle.load(f)
    except FileNotFoundError as e:
        fav_chars = set()

    yield fav_chars

    with open(path, 'wb') as f:
        pickle.dump(fav_chars, f)

