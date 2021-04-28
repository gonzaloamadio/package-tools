#!/bin/bash

. $VENV/bin/activate
source run_flake8.sh || true

export COVERAGE_PRINT_CONSOLE_REPORT=0
export COVERAGE_OPEN_REPORT_BROWSER=0
source run_coverage_unittest.sh || true
