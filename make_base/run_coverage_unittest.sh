#!/bin/bash

set +e

printf "\n${GREEN} Running tests ... ${NC} --> coverage run -m unittest\n"

coverage run -m unittest
printf "\n${GREEN} Creating coverage reports ... ${NC} --> coverage report $UNITTEST_COVERAGE_PARAMETERS\n\n"

coverage report $UNITTEST_COVERAGE_PARAMETERS || true # we want html report anyway

coverage html
open htmlcov/index.html
