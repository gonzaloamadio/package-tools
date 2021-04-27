#!/bin/bash

set -eo pipefail

set +e
SAFETY_COMMAND=$(which safety)
set -e

SAFETY_REPORT_NAME="safety_report.txt"
SAFETY_OUTPUT_FILE="$MAKE_BASE_DIR/$SAFETY_REPORT_NAME"
PREVENT_SAFETY_FAILURE=${PREVENT_SAFETY_FAILURE:-1}

function print_safety_error {
    >&2 echo "
#####################################################################

  Safety Security Check Failure.

  Please check the report located among the artifacts:
  $SAFETY_REPORT_NAME

#####################################################################
"
}

if [ -z $SAFETY_COMMAND ]; then
    echo "Safety not found"
    exit 1
fi

echo "Running Safety security checks with command:"
echo "$ $VENV/bin/pip freeze | LC_ALL=C.UTF-8 LANG=C.UTF-8 $SAFETY_COMMAND check --full-report --stdin > $SAFETY_OUTPUT_FILE"
set +e
# Output all the packages installed in bamboo-virtualenv and make Safety check them
$VENV/bin/pip freeze | LC_ALL=C.UTF-8 LANG=C.UTF-8 $SAFETY_COMMAND check --full-report --stdin > $SAFETY_OUTPUT_FILE
SAFETY_RETCODE=$?
set -e
if [[ $PREVENT_SAFETY_FAILURE -eq 0 && $SAFETY_RETCODE -ne 0 ]]; then
    print_safety_error
    exit $SAFETY_RETCODE
fi
exit 0
