.DEFAULT_GOAL := help

#### Define these ####

export SHELL=/bin/zsh

COVERAGE_THRESHOLD = 85
FLAKE8_THRESHOLD = 0

# SOURCE_DIR = # Fill with repo name
SOURCE_DIR = package-tools

include ./make_base/Makefile.base

tests: coverage ## run tests quickly with the default Python
