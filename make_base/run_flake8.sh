#!/bin/bash
echo flake8 --count --exit-zero $FLAKE8_TARGET --output-file flake8_issues.txt
FLAKE8_ISSUES=$(flake8 --count --exit-zero $FLAKE8_TARGET --output-file flake8_issues.txt)

if [ -z "$FLAKE8_ISSUES" ]
then
	# Consistency, flake8 does not print nothing when returning 0 findings.
	FLAKE8_ISSUES=0
fi

if [ -z "$FLAKE8_THRESHOLD" ]; then
	FLAKE8_THRESHOLD=0
fi

FLAKE8_FAIL_MSG="\033[31m[FAIL] Flake8 found $FLAKE8_ISSUES issues. It is above threshold of $FLAKE8_THRESHOLD Issues.\033[0m"
FLAKE8_FAIL_MSG_EX="$FLAKE8_FAIL_MSG Check flake8_issues.txt for more information"

if [ $FLAKE8_ISSUES -gt $FLAKE8_THRESHOLD ]
then
    echo -e $FLAKE8_FAIL_MSG_EX >&2
	exit 1
fi

echo "Flake8 found $FLAKE8_ISSUES issues. It is equal or below threshold of $FLAKE8_THRESHOLD issues. Check flake8_issues.txt for more information"
