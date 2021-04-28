#!/bin/bash

echo coverage run manage.py test
coverage run manage.py test || true
coverage html


GREEN='\033[0;32m'
NC='\033[0m' # No Color
echo;echo;
printf "To see the coverage report in stdout execute: ${GREEN}coverage report${NC}\n"
printf "To see a better and interactive html report open ${GREEN}htmlconv/index.html${NC}\n"
echo;echo;

open htmlcov/index.html
