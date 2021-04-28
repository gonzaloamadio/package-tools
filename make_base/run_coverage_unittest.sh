#!/bin/bash

set +e


echo coverage report $UNITTEST_COVERAGE_PARAMETERS
coverage report $UNITTEST_COVERAGE_PARAMETERS || true # we want html report anyway
coverage html
open htmlcov/index.html
