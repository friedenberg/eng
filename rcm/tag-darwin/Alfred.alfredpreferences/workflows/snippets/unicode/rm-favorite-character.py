#! /usr/bin/python3

import sys
import os
import alfred

new_char = ord(sys.argv[1])

with alfred.favorites() as f:
    f.remove(new_char)
