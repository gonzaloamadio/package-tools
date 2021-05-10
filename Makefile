.DEFAULT_GOAL := help

################ Define these ################

export SHELL=/bin/zsh

COVERAGE_THRESHOLD = 85
FLAKE8_THRESHOLD = 0

# SOURCE_DIR = # Fill with repo name
SOURCE_DIR = package_tools
TESTS_DIR = tests

FORMAT_THIS_FOLDERS_WITH_BLACK_FORMATTER = $(SOURCE_DIR) $(TESTS_DIR) 

include ./make_base/Makefile.base

############# END OF BOILERPLATE ###############

tests: coverage ## run tests quickly with the default Python
