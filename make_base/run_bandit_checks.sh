#!/bin/bash

set -eo pipefail

set +e
BANDIT_COMMAND=$(which bandit)
set -e

BANDIT_QUIET_OPTION=-q
BANDIT_SEVERITY_LEVEL=${BANDIT_SEVERITY_LEVEL:-"LOW"}
BANDIT_SEVERITY_OPTION_STR="l"
BANDIT_CONFIDENCE_LEVEL=${BANDIT_CONFIDENCE_LEVEL:-"LOW"}
BANDIT_CONFIDENCE_OPTION_STR="q"
# TODO Maybe we can check if the files listed here exist before running bandit
BANDIT_FILES_TO_CHECK=${BANDIT_FILES_TO_CHECK:-"-r $SOURCE_DIR"}
BANDIT_FILES_TO_EXCLUDE="-x tests"
BANDIT_REPORT_NAME="bandit_report.html"
BANDIT_OUTPUT_FILE="$MAKE_BASE_DIR/$BANDIT_REPORT_NAME"
BANDIT_OUTPUT="-o $BANDIT_OUTPUT_FILE"
BANDIT_FORMAT="--format html"
PREVENT_BANDIT_FAILURE=${PREVENT_BANDIT_FAILURE:-1}

function print_bandit_error {
    >&2 echo "
#####################################################################

  Bandit Security Check Failure.

  Severity Level Threshold: $BANDIT_SEVERITY_LEVEL
  Confidence Level Threshold: $BANDIT_CONFIDENCE_LEVEL

  Please check the report located among the artifacts:
  $BANDIT_REPORT_NAME

#####################################################################
"
}

function translate_level_to_option {
    LEVEL=$1
    OPTION=$2
    OPTION_NAME=$3
    case $LEVEL in
        HIGH)
            OPTION_REPETITION=$(printf "$OPTION%.0s" {1..3})
            ;;
        MEDIUM)
            OPTION_REPETITION=$(printf "$OPTION%.0s" {1..2})
            ;;
        LOW)
            OPTION_REPETITION=$(printf "$OPTION%.0s" {1..1})
            ;;
        *)
            >&2 echo "Invalid option '$LEVEL' for $OPTION_NAME. It must be one of HIGH, MEDIUM, LOW"
            return 1
    esac
    echo "-$OPTION_REPETITION"
    return 0
}

if [ -z $BANDIT_COMMAND ]; then
    echo "Bandit executable not found."
    exit 1
fi

BANDIT_SEVERITY_OPTION=$(translate_level_to_option $BANDIT_SEVERITY_LEVEL $BANDIT_SEVERITY_OPTION_STR "BANDIT_SEVERITY_LEVEL")
BANDIT_CONFIDENCE_OPTION=$(translate_level_to_option $BANDIT_CONFIDENCE_LEVEL $BANDIT_CONFIDENCE_OPTION_STR "BANDIT_CONFIDENCE_LEVEL")

BANDIT_FULL_COMMAND="$BANDIT_COMMAND $BANDIT_QUIET_OPTION $BANDIT_SEVERITY_OPTION $BANDIT_CONFIDENCE_OPTION $BANDIT_FORMAT $BANDIT_OUTPUT $BANDIT_FILES_TO_CHECK $BANDIT_FILES_TO_EXCLUDE"
echo "Running Bandit security checks with command:"
echo "$ $BANDIT_FULL_COMMAND"
set +e
$BANDIT_FULL_COMMAND
BANDIT_RETCODE=$?
set -e
if [[ $PREVENT_BANDIT_FAILURE -eq 0 && $BANDIT_RETCODE -ne 0 ]]; then
    print_bandit_error
    exit $BANDIT_RETCODE
fi
exit 0
