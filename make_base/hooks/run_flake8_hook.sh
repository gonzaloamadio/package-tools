#!/bin/bash

FLAKE8_BIN=$(which flake8)

if [ -z "$FLAKE8_BIN" ]; then
	echo "Could not find a flake8 binary to call, maybe you are outside a virtualenv?"
	exit 1
else
	echo "Using flake8 bin: "$FLAKE8_BIN
fi

make flake8