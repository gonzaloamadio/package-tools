#!/usr/bin/env python
# The above shebang loads first the user's env variables to point to the venv python

import re
import sys

filenames = sys.argv[1:]

# Parses list of makefiles searching for pattern
# <target>: .... ## description
# If two makefiles have the same target, the description will be shown
# for the first makefile in the list

results = {}
for filename in filenames:
    with open(filename, "r") as f:
        lines = f.readlines()
        for line in lines:
            match = re.match(r"^([a-zA-Z0-9_-]+):.*?## (.*)$$", line)
            if match:
                target, description = match.groups()
                if target not in results:
                    results[target] = description


for target, description in sorted(results.items()):
    print("%-20s %s" % (target, description))
