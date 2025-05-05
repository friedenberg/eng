#! /usr/bin/python3

import sys
import os
import alfred

new_char = sys.argv[1]
char_number = ord(new_char)

with alfred.favorites() as f:
    f.add(char_number)

print(new_char, end = '')
