#!/usr/bin/python3

import sys
with open(sys.argv[1], 'r+b') as fp:
    fp.seek(0xbd)
    fp.write(b'\xf0')
