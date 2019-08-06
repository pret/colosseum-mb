#!/usr/bin/python3

import sys
fp = open(sys.argv[1], 'r+b')
fp.seek(0xbd)
fp.write(b'\xf0')
fp.close()
