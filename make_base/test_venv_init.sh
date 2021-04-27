#!/bin/bash
set -euo pipefail

function print_dependencies
{
    echo Dependencies summary checksum: $(PIP_FIND_LINKS= pip -q freeze | md5sum | sed -E 's/ .+//')
    PIP_FIND_LINKS= pip -q freeze
}

if [[ $USE_DEV_REQUIREMENTS == 1 ]]; then
    req_file=requirements.txt
else
    req_file=requirements_dev.txt
fi

echo
echo
echo "Installing requirementes in the following venv:"
echo "$VIRTUAL_ENV/bin/pip install -r $req_file"
echo
echo

pip install -r $req_file
echo Dependencies after pip run:
print_dependencies
